export class ReplyReview {
  id: number = 0;
  replyId: number = 0;
  userId: number = 0;
  helpful: boolean = false;
  inappropriate: boolean = false;
  flagRemarks: string = '';

  constructor(
    id: number = 0,
    replyId: number = 0,
    userId: number = 0,
    helpful: boolean = false,
    inappropriate: boolean = false,
    flagRemarks: string = ''
  ) {
    this.id = id;
    this.replyId = replyId;
    this.userId = userId;
    this.helpful = helpful;
    this.inappropriate = inappropriate;
    this.flagRemarks = flagRemarks;
  }
}
