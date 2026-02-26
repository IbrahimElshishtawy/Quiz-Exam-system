import { Injectable } from '@nestjs/common';

@Injectable()
export class ExamsService {
  private exams = [];
  private sessions = [];

  createExam(examData: any) {
    const exam = { id: Date.now().toString(), ...examData };
    this.exams.push(exam);
    return exam;
  }

  startSession(userId: string, examId: string) {
    const exam = this.exams.find(e => e.id === examId);
    // Randomization logic here
    const session = {
      id: Date.now().toString(),
      userId,
      examId,
      startTime: new Date(),
      status: 'active',
      questions: this.shuffle(exam.questions || []),
    };
    this.sessions.push(session);
    return session;
  }

  private shuffle(array: any[]) {
    return array.sort(() => Math.random() - 0.5);
  }

  submitAnswer(sessionId: string, questionId: string, answer: any) {
    const session = this.sessions.find(s => s.id === sessionId);
    // incremental save logic
    return { status: 'saved' };
  }
}
