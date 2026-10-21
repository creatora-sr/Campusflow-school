# School & College Management Website — Requirements

## 1. Project ka goal

Ek responsive web application banana jahan school/college staff students, attendance, assignments aur exams ko ek jagah se manage kar saken. Repository mein React frontend aur Express/MongoDB backend ka basic structure hai; kai API routes abhi placeholder responses dete hain.

## 2. Users aur scope

### MVP users
- **Admin/Staff:** students aur academic records ko create, view, update aur delete kare.

### MVP ke bahar (baad mein add kiya ja sakta hai)
- Student/parent login aur self-service portal
- Fees, timetable, notifications, online assignment submission
- Multiple institutions ya advanced role permissions

> Assumption: pehle version mein ek institution aur staff-facing dashboard hoga. Login/authorization production use se pehle zaroori hai; ise implementation ke MVP tasks mein shamil kiya gaya hai.

## 3. Functional requirements

### FR-01: Navigation aur dashboard
- Home/dashboard se Students, Attendance, Assignments aur Exams sections tak pahunch ho.
- Current section ka naam, useful summary/counts, loading state aur API error message dikhaya jaye.
- Navigation keyboard aur mobile screen par bhi kaam kare.

### FR-02: Student management
- Student list dekhna, refresh karna, aur naam/admission number se search karna.
- Student add, details dekhna, edit aur delete karna.
- Zaroori fields: naam, admission number (unique), class/grade, section; optional: email, phone, guardian details, address.
- Invalid/missing fields par user ko samajhne layak validation dikhana.

### FR-03: Attendance management
- Student aur date ke hisaab se attendance records dekhna/filter karna.
- Attendance mark/edit karna: present, absent, late (school policy ke mutabik).
- Ek student ki ek date par duplicate attendance na bane.
- Date-wise attendance summary/count dikhana.

### FR-04: Assignment management
- Assignment list dekhna aur class/subject ke hisaab se filter karna.
- Assignment create, edit aur delete karna.
- Fields: title, description, class/section, subject, assigned date, due date.
- Due date assigned date se pehle na ho.

### FR-05: Exam management
- Exam list dekhna aur class/subject/date se filter karna.
- Exam create, edit aur delete karna.
- Fields: title/name, class/section, subject, exam date, maximum marks; optional: duration/room.
- Exam date aur maximum marks validate karna.

### FR-06: API aur data persistence
- Frontend data ko Express REST API ke madhyam se load/save kare; browser refresh ke baad data bana rahe.
- CRUD endpoints consistent JSON response aur HTTP status codes dein.
- MongoDB connection/configuration environment variables se aaye; secrets source control mein na hon.
- API validation aur not-found/server errors ka consistent response format ho.

### Attendance aur assignment API filters

- Dono APIs login ke baad hi available hain; list endpoints pagination use karte hain (`page`, `limit`).
- `GET /api/attendance` filters: `studentId`, `className`, `section`, `date` ya inclusive `from`/`to`, `status`.
- `GET /api/assignments` filters: `studentId`, `className`, `section`, `subject`, due-date `from`/`to`, title/subject `search`.
- Student ke liye assignments fetch karte waqt uski class/section ke class-wide assignments aur uske liye specifically assigned work return hota hai.
- Attendance record ke class/section uske mark hone ke waqt ke student profile se liye jaate hain. Ek student ke ek din par ek hi attendance mark ho sakta hai.

### FR-07: Authentication aur access
- Staff ke liye secure login/logout.
- Protected management pages/API bina login ke accessible na hon.
- Password secure hash ke roop mein store ho; authorization check backend par ho.

## 4. Non-functional requirements

- **Responsive:** phone, tablet aur desktop par usable layout.
- **Usability:** forms mein labels, validation, success/error feedback aur delete confirmation.
- **Accessibility:** semantic HTML, keyboard navigation, visible focus aur form errors ka accessible association.
- **Security:** input validation/sanitization, restricted CORS, secure secrets, password hashing, auth checks; production mein HTTPS.
- **Reliability:** API fail hone par app crash na ho; loading, empty aur error states dikhaye.
- **Performance:** normal list views ke liye pagination/limit support; unnecessary repeated API calls se bache.
- **Maintainability:** frontend/backend configuration alag, reusable components/API helpers aur documented setup.
- **Testing:** critical validation, CRUD API aur primary UI flows ke automated tests.

## 5. Data model (MVP proposal)

- **Student:** `name`, `admissionNumber`, `className`, `section`, `email?`, `phone?`, `guardianName?`, `address?`, timestamps.
- **Attendance:** `studentId`, `date`, `status` (`present | absent | late`), `remarks?`, timestamps. Unique constraint: `studentId + date`.
- **Assignment:** `title`, `description?`, `className`, `section?`, `subject`, `assignedDate`, `dueDate`, optional `studentId` for student-only work, timestamps.
- **Exam:** `title`, `className`, `section?`, `subject`, `examDate`, `maxMarks`, `duration?`, `room?`, timestamps.
- **Staff user:** `name`, unique `email`, `passwordHash`, `role`, timestamps.

## 6. Acceptance criteria

- Staff login ke baad chaaron modules khol sake; logged-out user protected data/API access na kar sake.
- Har module ka list real MongoDB data se aaye aur add/edit/delete ke baad list update ho.
- Form validation aur API/network errors user ko dikhaye jayen.
- Attendance duplicate constraint aur required field/date/marks validations backend par bhi enforce hon.
- App desktop aur mobile viewport par usable ho.
- Setup instructions follow karke frontend/backend run kiye ja saken aur automated tests pass hon.

## 7. Open decisions

Implementation se pehle institution se confirm karein: class/section naming, attendance statuses, date/time zone, grading/marks rules, student data privacy/retention, staff roles, aur login method. In decisions ke bina upar ke defaults MVP assumptions hain.
