import { User } from "./user";

export class BootcampReview {
  id: number = 0;
  user: User | null = null;
  bootcampId: number = 0;
  overallRating: number = 0;
  instructorRating: number = 0;
  jobAssistanceRating: number = 0;
  graduationDate: Date = new Date();
  bootcampReview: string = '';
  reviewDate: Date = new Date();
  curriculumRating: number = 0;


  constructor(
    id: number = 0,
    user: User | null = null,
    bootcampId: number = 0,
    overallRating: number = 0,
    instructorRating: number = 0,
    jobAssistanceRating: number = 0,
    graduationDate: Date = new Date(),
    bootcampReview: string = '',
    reviewDate: Date = new Date(),
    curriculumRating: number = 0
  ) {
    this.id = id;
    this.user = user;
    this.bootcampId = bootcampId;
    this.overallRating = overallRating;
    this.instructorRating = instructorRating;
    this.jobAssistanceRating = jobAssistanceRating;
    this.graduationDate = graduationDate;
    this.bootcampReview = bootcampReview;
    this.reviewDate = reviewDate;
    this.curriculumRating = curriculumRating;
  }

}
