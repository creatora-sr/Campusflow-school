# Test Evidence — CampusFlow

**Run date:** 2026-10-20  
**Result:** PASS — backend 19/19, frontend 19/19, production build successful.

## Commands and overall results

| Area | Command (run from) | Result |
|---|---|---|
| Backend tests | `npm.cmd test` (`server/`) | 19 passed, 0 failed |
| Frontend tests | `npm.cmd test -- --reporter=verbose` (`client/`) | 19 passed, 0 failed |
| Frontend production build | `npm.cmd run build` (`client/`) | Successful |
| Dependency audit | `npm.cmd audit` (`server/`) | 0 vulnerabilities |

## Backend test cases

| # | Test case | Evidence / assertions exercised | Result |
|---:|---|---|:---:|
| 1 | Student routes reject requests without a session | Unauthenticated student-list request returns HTTP 401. (`server/test/api.test.js`) | PASS |
| 2 | Student model requires identifying fields and unique admission numbers | Required name/admission/class/section and unique admission-number schema option. (`server/test/api.test.js`) | PASS |
| 3 | Login rejects invalid credentials and valid session identifies staff | Wrong password returns 401; `/me` returns the signed-in user; logout expires the cookie. (`server/test/api.test.js`) | PASS |
| 4 | Student API validates, creates, reads, updates, and deletes | Missing fields/invalid email rejected; create/read/update/delete succeed; duplicate admission number returns 409; malformed ID returns 400. (`server/test/api.test.js`) | PASS |
| 5 | Student listing searches safely and paginates | Page 2 returns expected records; search input is treated literally. (`server/test/api.test.js`) | PASS |
| 6 | MongoDB-backed login and student CRUD persist, validate, search, and paginate | Uses `mongodb-memory-server`; verifies authenticated CRUD, persistence, duplicate handling, search, and pagination. (`server/test/integration.test.js`) | PASS |
| 7 | Attendance API records, filters, validates, and enforces one mark per student per day | Requires authentication; rejects invalid date; creates, filters/populates, updates, rejects a duplicate day record, and deletes attendance. (`server/test/integration.test.js`) | PASS |
| 8 | Assignment API supports class and student targeting, filters, CRUD, and date validation | Rejects due date before assigned date; creates class/student-targeted work; checks student/class filters; updates and deletes. (`server/test/integration.test.js`) | PASS |
| 9 | Student portal credentials expose only that student's attendance and classwork | Student login/session, private records, class-wide vs individual assignments, own submission, staff-route denial, and logout. (`server/test/integration.test.js`) | PASS |
| 10 | Assignment submission API validates students and persists text or attachment submissions | Rejects empty/wrong-class submissions; creates/updates one submission; lists it and reports submission count. (`server/test/integration.test.js`) | PASS |
| 11 | Attendance model links a student and enforces one record per day | Checks `Student` reference, required student, unique `{ studentId, date }` index, date normalization, and status enum. (`server/test/models.test.js`) | PASS |
| 12 | Assignment model links optional students and rejects due dates before assignment | Checks optional `Student` reference and rejects due date earlier than assigned date. (`server/test/models.test.js`) | PASS |
| 13 | Class, subject, exam, and result models persist their relations and unique marks | Persists/populates class and subject references, exam and student result references; duplicate result is rejected and marks above exam maximum fail validation. (`server/test/integration.test.js`) | PASS |
| 14 | Class model normalizes sections and prevents duplicate class names per academic year | Sections normalize to uppercase and compound unique index is present. (`server/test/models.test.js`) | PASS |
| 15 | Subject model associates subjects with classes | Class reference array and unique name/class index metadata are present. (`server/test/models.test.js`) | PASS |
| 16 | Exam model requires class and subject references and positive maximum marks | `Class`/`Subject` refs required; zero maximum marks fails validation. (`server/test/models.test.js`) | PASS |
| 17 | Result model links an exam and student, prevents duplicate results, and caps marks | Required refs, unique exam/student index, and marks-not-over-maximum validation. (`server/test/models.test.js`) | PASS |
| 18 | Exam API protects and supports filtered CRUD with reference and result safeguards | Auth required; invalid dates/marks rejected; populated create/read, filtered list, update, results-protected changes/deletion, and delete. (`server/test/integration.test.js`) | PASS |
| 19 | Exam, marks, reports, and role permissions work end to end | Exercises the connected exam API alongside marks, reports, and staff/student authorization. (`server/test/integration.test.js`) | PASS |

## Frontend test cases

| # | Test case | Evidence / assertions exercised | Result |
|---:|---|---|:---:|
| 1 | Loads assignments from the API and shows submission count | Assignment list displays API data and submission count. (`client/src/components/AssignmentsDashboard.test.jsx`) | PASS |
| 2 | Loads and displays students from the API | Student list and admission number render; pagination parameters are sent. (`client/src/components/StudentDashboard.test.jsx`) | PASS |
| 3 | Requires sign-in before showing the dashboard | Unauthenticated visit shows login and hides the dashboard. (`client/src/App.test.jsx`) | PASS |
| 4 | Submits credentials and opens the protected dashboard | Login request uses entered credentials; dashboard opens; sign-out returns to login. (`client/src/App.test.jsx`) | PASS |
| 5 | Searches students and sends the query to the API | Search text and page are passed to the API. (`client/src/components/StudentDashboard.test.jsx`) | PASS |
| 6 | Creates a class assignment | Form submits class assignment and displays confirmation. (`client/src/components/AssignmentsDashboard.test.jsx`) | PASS |
| 7 | Records a student submission with text and attachment link | Submission payload is sent and status updates. (`client/src/components/AssignmentsDashboard.test.jsx`) | PASS |
| 8 | Shows a readable message when credentials are rejected | Login error is displayed accessibly. (`client/src/App.test.jsx`) | PASS |
| 9 | Adds a student and refreshes the directory | Required form data is posted and success feedback appears. (`client/src/components/StudentDashboard.test.jsx`) | PASS |
| 10 | Opens the protected attendance register from its route | Protected dashboard renders the attendance register. (`client/src/App.test.jsx`) | PASS |
| 11 | Edits a student record | Updated data is sent with PUT and success feedback appears. (`client/src/components/StudentDashboard.test.jsx`) | PASS |
| 12 | Asks before deleting and removes a student | Confirmation is shown; DELETE is sent; list and success feedback update. (`client/src/components/StudentDashboard.test.jsx`) | PASS |
| 13 | Shows API errors instead of failing silently | API failure appears in an accessible alert. (`client/src/components/StudentDashboard.test.jsx`) | PASS |
| 14 | Opens the protected assignment register from its route | Protected dashboard renders the assignment register. (`client/src/App.test.jsx`) | PASS |
| 15 | Lets a student sign in with an admission number and view their own portal | Student login routes to the student portal and loads their data. (`client/src/App.test.jsx`) | PASS |
| 16 | Loads a class roster and date-specific attendance view | Attendance screen requests roster and date-filtered records. (`client/src/components/AttendanceDashboard.test.jsx`) | PASS |
| 17 | Marks a student present and saves the record through the API | Attendance action sends the expected create/update request. (`client/src/components/AttendanceDashboard.test.jsx`) | PASS |
| 18 | Student submits work and sees refreshed submission status | Student portal sends assignment submission and refreshes status. (`client/src/components/StudentPortal.test.jsx`) | PASS |
| 19 | Student portal shows API validation failures | Submission validation error is displayed. (`client/src/components/StudentPortal.test.jsx`) | PASS |

## Notes

- Backend persistence/integration tests use an ephemeral MongoDB instance; they do not require a developer's local MongoDB database.
- Frontend tests use mocked API responses; backend integration tests independently exercise the real Express/Mongoose APIs against the ephemeral database.
- The production build emitted a React Router `use client` bundler warning, but completed successfully.
- This report records automated test/build evidence; it is not a manual browser screenshot report.
