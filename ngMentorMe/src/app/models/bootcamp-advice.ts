export class BootcampAdvice {
  id: number = 0;
 bootcampReviewId: number = 0;
 title: string = '';
  advice: string = '';

  constructor(
    id: number = 0,
    bootcampReviewId: number = 0,
    title: string = '',
    advice: string = '')
     {
    this.id = id;
    this.bootcampReviewId = bootcampReviewId;
    this.title = title;
    this.advice = advice;
  }
}
