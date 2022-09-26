import { User } from "./user";

export class Reply {
  id: number = 0;
  postId?: number = 0;
  user?: User | null = null;
  replyId?: number = 0;
  text: string = '';
  created?: Date = new Date();
  updated?: Date = new Date();
  enabled: boolean = true;

  constructor(
    id: number = 0,
    postId: number = 0,
    user: User | null = null,
    replyId: number = 0,
    text: string = '',
    created: Date = new Date(),
    updated: Date = new Date(),
    enabled: boolean = true
  ) {
    this.id = id;
    this.postId = postId;
    this.user = user;
    this.replyId = replyId;
    this.text = text;
    this.created = created;
    this.updated = updated;
    this.enabled = enabled;
  }
}
