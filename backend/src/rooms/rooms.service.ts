import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Room } from './room.entity';

@Injectable()
export class RoomsService {
  constructor(
    @InjectRepository(Room)
    private roomsRepository: Repository<Room>,
  ) {}

  async createRoom(roomData: any) {
    const room = this.roomsRepository.create({
      ...roomData,
      code: Math.random().toString(36).substring(7).toUpperCase(),
    });
    return this.roomsRepository.save(room);
  }

  async joinRoom(code: string, password?: string) {
    const room = await this.roomsRepository.findOne({ where: { code } });
    if (!room) throw new NotFoundException('Room not found');
    if (room.password && room.password !== password) {
      throw new Error('Invalid password');
    }
    return room;
  }

  async getRoomById(id: string) {
    return this.roomsRepository.findOne({ where: { id } });
  }
}
