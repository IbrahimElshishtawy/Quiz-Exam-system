# Scaling Strategy

## Frontend (Flutter)
- **Deferred Loading**: Use `GetPage` with lazy bindings to keep the initial bundle small.
- **Efficient Rebuilds**: Minimize `Obx` scope to specific widgets rather than entire screens.
- **Caching**: Utilize `GetStorage` for local caching of question banks to support offline exam windows.

## Backend (NestJS)
- **Redis Session Locking**: Prevent multiple simultaneous exam submissions.
- **Database Indexing**: Optimized queries for `studentId` and `examId` in the `answers` table.
- **Horizontal Scaling**: Stateless API design allowing for multiple instances behind a load balancer.

## Real-time Monitoring
- Use **WebSockets** (Socket.io) for live proctoring events instead of polling.
- Throttling of anti-cheat events (e.g., focus loss) to prevent flooding the server during peak exam hours.
