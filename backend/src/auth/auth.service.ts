import { Injectable, UnauthorizedException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import * as bcrypt from 'bcrypt';
import { RedisService } from '../redis/redis.service';

@Injectable()
export class AuthService {
  constructor(
    private jwtService: JwtService,
    private redisService: RedisService,
  ) {}

  async login(user: any, deviceId: string) {
    const payload = { username: user.username, sub: user.id, role: user.role };
    const accessToken = this.jwtService.sign(payload, { expiresIn: '15m' });
    const refreshToken = this.jwtService.sign(payload, { expiresIn: '7d' });

    // Device binding & Session locking: store refresh token in Redis with deviceId
    await this.redisService.set(`session:${user.id}:${deviceId}`, refreshToken, 604800);

    return {
      access_token: accessToken,
      refresh_token: refreshToken,
    };
  }

  async refreshToken(oldRefreshToken: string, deviceId: string) {
    try {
      const payload = this.jwtService.verify(oldRefreshToken);
      const storedToken = await this.redisService.get(`session:${payload.sub}:${deviceId}`);

      if (!storedToken || storedToken !== oldRefreshToken) {
        throw new UnauthorizedException('Invalid refresh token or session expired');
      }

      // Refresh token rotation
      const newPayload = { username: payload.username, sub: payload.sub, role: payload.role };
      const newAccessToken = this.jwtService.sign(newPayload, { expiresIn: '15m' });
      const newRefreshToken = this.jwtService.sign(newPayload, { expiresIn: '7d' });

      await this.redisService.set(`session:${payload.sub}:${deviceId}`, newRefreshToken, 604800);

      return {
        access_token: newAccessToken,
        refresh_token: newRefreshToken,
      };
    } catch (e) {
      throw new UnauthorizedException('Invalid refresh token');
    }
  }

  async logout(userId: string, deviceId: string) {
    await this.redisService.del(`session:${userId}:${deviceId}`);
  }
}
