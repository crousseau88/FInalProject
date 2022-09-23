export class PostReview {
  id: number = 0;
  userId: number = 0;
  postId: number = 0;
  helpful: boolean = false;
  inappropriate: boolean = false;
  flagRemarks: string = '';

  constructor(
    id: number = 0,
    userId: number = 0,
    postId: number = 0,
    helpful: boolean = false,
    inappropriate: boolean = false,
    flagRemarks: string = ''
  ) {
    this.id = 0;
    this.userId = 0;
    this.postId = 0;
    this.helpful = false;
    this.inappropriate = false;
    this.flagRemarks = '';
  }
}
