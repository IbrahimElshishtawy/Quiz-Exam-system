import { Module } from '@nestjs/common';
import { AuthModule } from './auth/auth.module';
import { RoomsModule } from './rooms/rooms.module';
import { ExamsModule } from './exams/exams.module';

@Module({
  imports: [
    AuthModule,
    RoomsModule,
    ExamsModule,
  ],
})
export class AppModule {}
