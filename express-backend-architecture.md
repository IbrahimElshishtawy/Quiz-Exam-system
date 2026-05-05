# Node.js Backend Architecture for Educational Testing Platform

This document outlines the architecture for a production-ready Node.js backend using Clean Architecture principles. The stack includes Node.js, Express.js, MongoDB with Mongoose, Socket.io, and JWT-based authentication.

## 1. Project Structure (Clean Architecture)

```
src/
├── app.ts                  # App entry point (Express & Socket.io setup)
├── server.ts               # Server startup logic
├── config/                 # Environment variables & configuration
│   └── database.ts         # MongoDB connection setup
├── domain/                 # Layer 1: Enterprise Business Rules (Entities & Interfaces)
│   ├── entities/           # Core business objects/interfaces
│   │   ├── User.ts
│   │   ├── Exam.ts
│   │   └── Session.ts
│   └── repositories/       # Repository interfaces (Contracts)
│       ├── IUserRepository.ts
│       ├── IExamRepository.ts
│       └── ISessionRepository.ts
├── application/            # Layer 2: Application Business Rules (Use Cases)
│   ├── useCases/           # Application-specific logic
│   │   ├── auth/
│   │   └── session/
│   │       ├── JoinSessionUseCase.ts
│   │       └── CreateSessionUseCase.ts
│   └── services/           # Application-level services (e.g., token generation)
├── interfaces/             # Layer 3: Interface Adapters (Controllers, Routes, Gateways)
│   ├── controllers/        # HTTP Request handlers
│   │   ├── AuthController.ts
│   │   └── SessionController.ts
│   ├── routes/             # Express routes definitions
│   │   ├── authRoutes.ts
│   │   └── sessionRoutes.ts
│   ├── middlewares/        # Express middlewares (Auth, Error handling, Validation)
│   │   ├── authMiddleware.ts
│   │   └── errorHandler.ts
│   └── gateways/           # WebSocket/Socket.io handlers
│       └── ProctoringGateway.ts
└── infrastructure/         # Layer 4: Frameworks & Drivers (DB, External Services)
    ├── database/           # DB Implementations
    │   ├── mongoose/       # Mongoose Schemas & Models
    │   │   ├── UserModel.ts
    │   │   ├── ExamModel.ts
    │   │   └── SessionModel.ts
    │   └── repositories/   # Implementation of repository interfaces
    │       ├── MongoUserRepository.ts
    │       └── MongoSessionRepository.ts
    └── services/           # External service implementations (e.g., Redis, Email)
```

## 2. Core Models (Mongoose Schemas)

Located in `src/infrastructure/database/mongoose/`:

### UserModel.ts
```typescript
import mongoose, { Schema, Document } from 'mongoose';

export interface IUser extends Document {
  name: string;
  email: string;
  passwordHash: string;
  role: 'Teacher' | 'Student';
}

const UserSchema: Schema = new Schema({
  name: { type: String, required: true },
  email: { type: String, required: true, unique: true, index: true },
  passwordHash: { type: String, required: true },
  role: { type: String, enum: ['Teacher', 'Student'], required: true }
}, { timestamps: true });

export const UserModel = mongoose.model<IUser>('User', UserSchema);
```

### ExamModel.ts
```typescript
import mongoose, { Schema, Document } from 'mongoose';

export interface IQuestion {
  text: string;
  options: string[];
  correct_index: number;
  type: 'multiple_choice' | 'true_false'; // Add other types as needed
}

export interface IExam extends Document {
  title: string;
  teacherId: mongoose.Types.ObjectId;
  questions: IQuestion[];
}

const QuestionSchema: Schema = new Schema({
  text: { type: String, required: true },
  options: [{ type: String, required: true }],
  correct_index: { type: Number, required: true },
  type: { type: String, required: true }
});

const ExamSchema: Schema = new Schema({
  title: { type: String, required: true, index: true },
  teacherId: { type: Schema.Types.ObjectId, ref: 'User', required: true, index: true },
  questions: [QuestionSchema]
}, { timestamps: true });

export const ExamModel = mongoose.model<IExam>('Exam', ExamSchema);
```

### SessionModel.ts
```typescript
import mongoose, { Schema, Document } from 'mongoose';

export interface ISession extends Document {
  examId: mongoose.Types.ObjectId;
  teacherId: mongoose.Types.ObjectId;
  access_code: string;
  status: 'waiting' | 'live' | 'finished';
  connected_students: mongoose.Types.ObjectId[];
}

const SessionSchema: Schema = new Schema({
  examId: { type: Schema.Types.ObjectId, ref: 'Exam', required: true },
  teacherId: { type: Schema.Types.ObjectId, ref: 'User', required: true },
  access_code: { type: String, required: true, unique: true, index: true },
  status: { type: String, enum: ['waiting', 'live', 'finished'], default: 'waiting' },
  connected_students: [{ type: Schema.Types.ObjectId, ref: 'User' }]
}, { timestamps: true });

export const SessionModel = mongoose.model<ISession>('Session', SessionSchema);
```

## 3. Real-time Logic (Socket.io)

Located in `src/interfaces/gateways/ProctoringGateway.ts`:

```typescript
import { Server, Socket } from 'socket.io';

export class ProctoringGateway {
  constructor(private io: Server) {
    this.setupListeners();
  }

  private setupListeners() {
    this.io.on('connection', (socket: Socket) => {
      console.log(`User connected: ${socket.id}`);

      // 1. Join a room via access_code
      socket.on('join_session', (data: { access_code: string; studentId: string; role: string }) => {
        const { access_code, studentId, role } = data;

        socket.join(access_code);
        console.log(`${role} ${studentId} joined session ${access_code}`);

        if (role === 'Student') {
            // Notify teacher that a student joined
            this.io.to(access_code).emit('student_joined', { studentId });
        }
      });

      // 2. Student emits 'cheat_detected' events
      socket.on('cheat_detected', (data: { access_code: string; studentId: string; eventType: 'app_exit' | 'screenshot' | 'focus_loss' }) => {
        const { access_code, studentId, eventType } = data;

        console.log(`Cheat detected: ${eventType} by ${studentId} in session ${access_code}`);

        // 3. Teachers receive these alerts in real-time
        // We broadcast to the room. The client-side logic ensures only Teachers display the alert.
        // Alternatively, use separate rooms like `${access_code}_teachers`.
        socket.to(access_code).emit('proctoring_alert', {
          studentId,
          eventType,
          timestamp: new Date()
        });
      });

      socket.on('disconnect', () => {
        console.log(`User disconnected: ${socket.id}`);
        // Handle student disconnection logic (e.g., notify teacher)
      });
    });
  }
}
```

## 4. Sample Use Case & Controller

### JoinSessionUseCase.ts (Application Layer)
Located in `src/application/useCases/session/JoinSessionUseCase.ts`

```typescript
import { ISessionRepository } from '../../../domain/repositories/ISessionRepository';

export class JoinSessionUseCase {
  constructor(private sessionRepository: ISessionRepository) {}

  async execute(accessCode: string, studentId: string): Promise<any> {
    // 1. Find the session by access code
    const session = await this.sessionRepository.findByAccessCode(accessCode);

    if (!session) {
      throw new Error('Session not found or invalid access code.');
    }

    if (session.status === 'finished') {
      throw new Error('This session has already ended.');
    }

    // 2. Add student to connected_students if not already present
    // Note: sessionRepository implementation handles the actual DB update
    await this.sessionRepository.addStudentToSession(session.id, studentId);

    // 3. Return necessary session data (using lean principles in the repo)
    return {
      sessionId: session.id,
      examId: session.examId,
      status: session.status
    };
  }
}
```

### SessionController.ts (Interfaces Layer)
Located in `src/interfaces/controllers/SessionController.ts`

```typescript
import { Request, Response, NextFunction } from 'express';
import { JoinSessionUseCase } from '../../application/useCases/session/JoinSessionUseCase';

export class SessionController {
  constructor(private joinSessionUseCase: JoinSessionUseCase) {}

  // Bound to POST /sessions/join
  joinSession = async (req: Request, res: Response, next: NextFunction) => {
    try {
      const { access_code } = req.body;

      // Assuming auth middleware attaches user info to req.user
      const studentId = req.user?.id;

      // Basic input validation
      if (!access_code || typeof access_code !== 'string') {
        return res.status(400).json({ error: 'Valid access_code is required.' });
      }

      if (!studentId) {
          return res.status(401).json({ error: 'Unauthorized.' });
      }

      const sessionData = await this.joinSessionUseCase.execute(access_code, studentId);

      return res.status(200).json({
        message: 'Successfully joined session',
        data: sessionData
      });
    } catch (error: any) {
      // Pass to global error handler
      if (error.message === 'Session not found or invalid access code.' || error.message === 'This session has already ended.') {
          return res.status(404).json({ error: error.message });
      }
      next(error);
    }
  };
}
```

## 5. Fast API Principles

To ensure high performance and reliability, implement the following principles:

1.  **Use `.lean()` for Read-Only Operations:**
    When fetching data from MongoDB that won't be modified (e.g., retrieving exam questions for a student), use `.lean()` in your repository implementation. This bypasses Mongoose document instantiation, returning plain JavaScript objects and significantly improving read performance.

    *Example in MongoSessionRepository.ts:*
    ```typescript
    async findByAccessCode(accessCode: string): Promise<any> {
      // .lean() makes the query much faster
      return SessionModel.findOne({ access_code: accessCode }).lean().exec();
    }
    ```

2.  **Input Validation:**
    Use a validation library like `Joi` or `Zod` in middleware before requests hit the controller. This prevents invalid data from reaching your business logic.

    ```typescript
    // Example Zod schema middleware
    import { z } from 'zod';
    const joinSessionSchema = z.object({
        access_code: z.string().min(6).max(10)
    });
    ```

3.  **Global Error Handling:**
    Implement a centralized Express error handling middleware to catch unhandled exceptions, format error responses consistently, and prevent server crashes.

    ```typescript
    // src/interfaces/middlewares/errorHandler.ts
    export const errorHandler = (err: any, req: Request, res: Response, next: NextFunction) => {
      console.error(err.stack); // Log for debugging
      const statusCode = err.statusCode || 500;
      res.status(statusCode).json({
        error: statusCode === 500 ? 'Internal Server Error' : err.message
      });
    };
    ```

4.  **Database Indexing:**
    Ensure frequently queried fields (like `email` in User, `access_code` in Session, and foreign keys like `teacherId`) are indexed in Mongoose schemas (as shown in the models above) to speed up lookups.
