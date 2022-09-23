export class DirectMessage {
  id: number = 0;
  senderId: number = 0;
  recipientId: number = 0;
  date: Date = new Date();
  content: string = '';
  enabled: boolean = true;

  constructor(
    id: number = 0,
    senderId: number = 0,
    recipientId: number = 0,
    date: Date = new Date(),
    content: string = '',
    enabled: boolean = true
  ) {
    this.id = id;
    this.senderId = senderId;
    this.recipientId = recipientId;
    this.date = date;
    this.content = content;
    this.enabled = enabled;
  }
}
