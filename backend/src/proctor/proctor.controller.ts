import { Controller, Post, Body, Param } from '@nestjs/common';

@Controller('proctor')
export class ProctorController {
  @Post('event/:sessionId')
  logEvent(@Param('sessionId') sessionId: string, @Body() body: any) {
    console.log(`Proctor Event for ${sessionId}: ${body.type}`);
    // Save to DB/Audit log
    return { status: 'logged' };
  }
}
