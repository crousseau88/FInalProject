export class BootcampReview {
  id: number = 0;
  userID: number = 0;
  bootcampId: number = 0;
  overallRating: number = 0;
  instructorsRating: number = 0;
  jobAssistRating: number = 0;
  graduationDate: Date = new Date();
  bootcampReview: string = '';
  reviewDate: Date = new Date();


  constructor(
    id: number = 0,
    userID: number = 0,
    bootcampId: number = 0,
    overallRating: number = 0,
    instructorsRating: number = 0,
    jobAssistRating: number = 0,
    graduationDate: Date = new Date(),
    bootcampReview: string = '',
    reviewDate: Date = new Date()
  ) {
    this.id = id;
    this.userID = userID;
    this.bootcampId = bootcampId;
    this.overallRating = overallRating;
    this.instructorsRating = instructorsRating;
    this.jobAssistRating = jobAssistRating;
    this.graduationDate = graduationDate;
    this.bootcampReview = bootcampReview;
    this.reviewDate = reviewDate;
  }

}
