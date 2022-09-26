import { User } from 'src/app/models/user';
import { Reply } from "./reply";

export class Post {
  id: number = 0;
  userPost: User | null = null;
  text: string = '';
  created: Date = new Date();
  updated: Date = new Date();
  enabled: boolean = true;
  subject: string = '';
  replies: Reply[] = [];

  constructor(
    id: number = 0,
    userPost: User | null = null,
    text: string = '',
    created: Date = new Date(),
    updated: Date = new Date(),
    enabled: boolean = true,
    subject: string = '',
    replies: Reply[] = []
  ) {
    this.id = 0;
    this.userPost = new User();
    this.text = '';
    this.created = new Date();
    this.updated = new Date();
    this.enabled = true;
    this.subject = '';
    this.replies = [];
  }
}
