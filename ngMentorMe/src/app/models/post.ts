export class Post {

  id: number = 0;
  userId: number = 0;
  text: string = '';
  created: Date = new Date();
  updated: Date = new Date();
  enabled: boolean = true;
  subject: string = '';

  constructor(
    id: number = 0,
    userId: number = 0,
    text: string = '',
    created: Date = new Date(),
    updated: Date = new Date(),
    enabled: boolean = true,
    subject: string = ''
  ) {
    this.id = 0;
    this.userId = 0;
    this.text = '';
    this.created = new Date();
    this.updated = new Date();
    this.enabled = true;
    this.subject = '';
  }

}
