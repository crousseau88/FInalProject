export class Reply {
  id: number = 0;
  postId: number = 0;
  userId: number = 0;
  replyId: number = 0;
  reply: string = '';
  created: Date = new Date();
  updated: Date = new Date();
  enabled: boolean = true;

  constructor(
    id: number = 0,
    postId: number = 0,
    userId: number = 0,
    replyId: number = 0,
    reply: string = '',
    created: Date = new Date(),
    updated: Date = new Date(),
    enabled: boolean = true
  ) {
    this.id = id;
    this.postId = postId;
    this.userId = userId;
    this.replyId = replyId;
    this.reply = reply;
    this.created = created;
    this.updated = updated;
    this.enabled = enabled;
  }
}
