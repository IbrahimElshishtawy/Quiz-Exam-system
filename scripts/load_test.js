import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  stages: [
    { duration: '30s', target: 50 }, // ramp up to 50 users
    { duration: '1m', target: 50 },  // stay at 50 users
    { duration: '30s', target: 0 },  // ramp down
  ],
};

export default function () {
  const url = 'http://localhost:3000/api/exams/1/submit';
  const payload = JSON.stringify({
    answers: [
      { questionId: 1, optionId: 2 },
      { questionId: 2, text: 'Sample essay response' }
    ],
  });

  const params = {
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer YOUR_TOKEN_HERE'
    },
  };

  const res = http.post(url, payload, params);
  check(res, { 'status was 201': (r) => r.status == 201 });
  sleep(1);
}
