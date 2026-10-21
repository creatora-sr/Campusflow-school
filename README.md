# CampusFlow — School Management

Tasks 1–3 deliver the staff sign-in, responsive dashboard, student directory, attendance register, assignment workflows, and student self-service records using React/Vite, Express, and MongoDB.

## Requirements

- Node.js 20 or newer (required by the current React Router release)
- MongoDB running locally, or a MongoDB Atlas connection URI

## Setup

1. This workspace's `server/.env` is configured for the local MongoDB database. On another machine, copy `server/.env.example` to `server/.env`, set the MongoDB URI, a private `JWT_SECRET` (at least 32 characters), and strong initial admin credentials. The first admin account is created on server startup; existing accounts are never overwritten.
2. Copy `client/.env.example` to `client/.env` if the API is not at `http://localhost:5000/api`.
3. In one terminal:

   ```powershell
   cd server
   npm.cmd install
   npm.cmd run dev
   ```

4. In another terminal:

   ```powershell
   cd client
   npm.cmd install
   npm.cmd run dev
   ```

5. Open `http://localhost:5173` and sign in using the admin email/password configured in `server/.env`.

The API health check is at `http://localhost:5000/api/health`. If local MongoDB is stopped, run `powershell -ExecutionPolicy Bypass -File .\server\start-local-mongo.ps1`; its persistent data directory is `server/data/`. Student endpoints require the signed, HTTP-only login cookie. Student records are stored in MongoDB; admission numbers are unique.

## Task 1 features

- Staff login and logout; password hashes use bcrypt and sessions use an HTTP-only JWT cookie.
- Responsive admin overview with live student count and recent enrollments.
- Searchable, paginated student list with add/edit/delete, confirmation, and server-side validation.
- API errors, empty/loading states, CORS allowlist, login rate limiting, and security headers.

## Task 2 features

- Daily attendance filtered by date, class, section, and student search; status can be marked, changed, or cleared.
- Attendance records are unique per student/date and stored in MongoDB.
- Assignment create/list/edit/delete with class-wide or student-specific targeting and due-date filtering.
- Staff and students can submit text, an external URL, or a direct PDF/PNG/JPG/WEBP/TXT upload (up to 10 MB), then view/download recorded work.
- Submission records are unique per assignment/student. Staff can record work from the assignment register, and students can submit/update their own work from the student portal.

## Student self-service portal

- Students sign in with their admission number and a portal password set by staff in the student add/edit form.
- The portal shows the student's own attendance and class assignments, and lets them submit or update assignment text, an attachment URL, or a direct file.
- Uploaded files are kept under `server/uploads/` and served only through authenticated download routes; production hosting needs a persistent disk or cloud object storage.
- The student session is separate from the staff session; student credentials cannot access staff management APIs.

## Task 3: Student portal

- Teachers/staff can set or reset a student's portal password from the student add/edit form. Passwords are bcrypt-hashed and are never returned by the API.
- From the sign-in screen, students choose **Student**, then sign in with their admission number and portal password.
- The student portal only returns that student's attendance history, assignments for their class/section (plus any specifically assigned to them), and their own submission status.
- Student sessions use a separate HTTP-only cookie; student sessions cannot access staff management APIs.

Exams and results are reserved for a later implementation task.

## Tests

Run the frontend component tests and backend API-route tests from their respective folders:

```powershell
cd client
npm.cmd test

cd ..\server
npm.cmd test
```

The backend suite includes API tests with stubbed models and a live integration test using a temporary MongoDB instance (`mongodb-memory-server`). The integration test downloads a MongoDB binary the first time it runs; no local MongoDB service or Atlas credentials are needed for the test suite. The app itself still needs a real MongoDB URI in `server/.env` to run persistently.
