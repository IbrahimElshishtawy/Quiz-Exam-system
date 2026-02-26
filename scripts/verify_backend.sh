#!/bin/bash
echo "Verifying Backend Endpoints..."

# Login
echo "Testing Login..."
curl -X POST http://localhost:3000/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username": "student1", "deviceId": "device123"}'

echo -e "\nTesting Room Join..."
curl -X POST http://localhost:3000/rooms/join \
  -H "Content-Type: application/json" \
  -d '{"code": "ROOM123"}'

echo -e "\nVerification script finished."
