import { Controller, Post, Body, Req, UseGuards } from '@nestjs/common';
import { AuthService } from './auth.service';

@Controller('auth')
export class AuthController {
  constructor(private authService: AuthService) {}

  @Post('login')
  async login(@Body() body: any) {
    // In real app, validate user from DB here
    const mockUser = { id: '1', username: body.username, role: 'student' };
    return this.authService.login(mockUser, body.deviceId);
  }

  @Post('refresh')
  async refresh(@Body() body: any) {
    return this.authService.refreshToken(body.refresh_token, body.deviceId);
  }

  @Post('logout')
  async logout(@Body() body: any) {
    return this.authService.logout(body.userId, body.deviceId);
  }
}
