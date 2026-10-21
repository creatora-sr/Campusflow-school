# Website Implementation Tasks

Is task list ka target `REQUIREMENTS.md` mein diya gaya School & College Management Website MVP hai. Existing code mein React pages aur Express routes ka skeleton hai, lekin routes abhi placeholder hain.

## Phase 1 — Project setup aur foundation

- [ ] **T-01: Existing app ko run karke baseline verify karein** — client/server dependencies, startup, routing aur current errors check karein.
- [ ] **T-02: Project configuration sudharein** — frontend/backend `.env.example`, API base URL, scripts aur setup instructions add karein; secrets commit na hon.
- [ ] **T-03: Shared UI foundation banayein** — app layout, responsive navigation, common button/input/table, loading/empty/error states.
- [x] **T-04: Frontend routing clean up karein** — nested routes/imports verify karein, invalid path ke liye not-found page aur mobile navigation add karein.

## Frontend design pass — visual prototype complete

- [x] School-management theme, sidebar navigation aur responsive page shell.
- [x] Dashboard overview cards, attendance chart, upcoming events aur student preview.
- [x] Students, Attendance, Assignments aur Exams ke list/table screens.
- [x] Add-record modal, search/filter controls aur mobile/tablet layouts.

> Initial visual prototype sample data se bana tha. Attendance/Assignments baad mein API-integrated hue; remaining integrations task list mein track ho rahe hain.

## Phase 2 — Backend aur database

- [ ] **T-05: MongoDB connection harden karein** — env validation, connection error handling aur startup tabhi jab DB ready ho.
- [ ] **T-06: Mongoose models banayein** — Student, Attendance, Assignment, Exam aur StaffUser; required fields, indexes aur constraints define karein.
- [ ] **T-07: Common API validation/error handling add karein** — consistent JSON errors, HTTP status codes aur invalid ObjectId handling.
- [ ] **T-08: Student CRUD API implement karein** — list/search/pagination, get-by-id, create, update, delete.
- [x] **T-09: Attendance CRUD API implement karein** — authenticated date/student/class/section filters, pagination, status validation aur student-date duplicate prevention.
- [x] **T-10: Assignment CRUD API implement karein** — authenticated class/student/subject filters, pagination, class-wide ya student-targeted assignments aur assigned/due date validation.
- [x] **T-11: Exam CRUD API implement karein** — class/subject/date filters, marks/results, reports aur role-based validation.
- [ ] **T-12: Staff authentication implement karein** — login/logout, password hashing, auth middleware aur protected API routes.
- [ ] **T-13: API security configure karein** — CORS allowlist, request size limits, secure headers aur production env guidance.

## Phase 3 — Frontend functionality

- [ ] **T-14: API client aur auth state banayein** — shared Axios/base URL, token/session handling aur unauthorized response handling.
- [ ] **T-15: Login screen aur protected routes banayein** — login validation, logout aur session expiry behavior.
- [x] **T-16: Home dashboard complete karein** — module links, attendance/assignment counts, upcoming exam aur result summary.
- [ ] **T-17: Student management UI complete karein** — searchable/paginated table, detail, add/edit form, delete confirmation.
- [x] **T-18: Attendance UI complete karein** — date/class filters, attendance marking/editing aur summary.
- [x] **T-19: Assignment UI complete karein** — list/filters aur create/edit/delete/submission forms.
- [x] **T-20: Exam UI complete karein** — schedule list/filters, create/edit/delete aur per-student marks entry.
- [x] **T-27: Marks/results page banayein** — class/exam filters, grade/pass summaries, marks entry/edit aur CSV export.
- [x] **T-28: Reports page banayein** — attendance/exam/assignment report builder, filters aur CSV download action.
- [ ] **T-21: UX/accessibility polish karein** — responsive states, labels, keyboard support, feedback messages aur destructive-action confirmation.

## Phase 4 — Quality aur release

- [x] **T-22: Backend tests likhein** — model validation, auth, CRUD endpoints, filters aur error cases.
- [ ] **T-23: Frontend tests likhein** — login aur chaar modules ke primary list/form flows.
- [ ] **T-24: End-to-end smoke test karein** — login → student add → attendance mark → assignment/exam create → edit/delete.
- [ ] **T-25: Documentation aur deployment setup karein** — install/run/test steps, env variables, production build aur deployment checklist.
- [ ] **T-26: Release review karein** — mobile/desktop check, security checklist, logs/errors aur acceptance criteria sign-off.

## Suggested order / dependencies

1. T-01 se T-04 (foundation)
2. T-05 se T-07 (backend foundation), phir T-08 se T-13 (API/auth)
3. T-14 se T-21 (frontend; module UI apne API ke saath integrate karein)
4. T-22 se T-26 (testing aur release)

> Authentication aur student-data privacy ko public/prod deployment se pehle complete karna release blocker hai. Open decisions ke liye `REQUIREMENTS.md` ka section 7 dekhein.

> Task 3 frontend pass complete: exam schedule UI API se wired hai. Marks/results page abhi demo data/local storage use karta hai; result endpoints aur report CSV endpoints ko backend se verify/integrate karna baaki hai.
