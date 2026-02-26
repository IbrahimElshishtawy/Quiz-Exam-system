import { Controller, Post, Get, Body, Param } from '@nestjs/common';
import { RoomsService } from './rooms.service';

@Controller('rooms')
export class RoomsController {
  constructor(private roomsService: RoomsService) {}

  @Post()
  create(@Body() body: any) {
    return this.roomsService.createRoom(body);
  }

  @Post('join')
  join(@Body() body: any) {
    return this.roomsService.joinRoom(body.code, body.password);
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.roomsService.getRoomById(id);
  }
}
