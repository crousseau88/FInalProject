import { AuthService } from 'src/app/services/auth.service';
import { Reply } from './../../models/reply';
import { Component, Input, OnInit } from '@angular/core';
import { PostInterface } from 'src/app/interfaces/post';
import { Post } from 'src/app/models/post';
import { User } from 'src/app/models/user';

@Component({
  selector: 'app-post',
  templateUrl: './post.component.html',
  styleUrls: ['./post.component.css'],
})
export class PostComponent implements OnInit{
  @Input() post!: PostInterface;
  @Input() currentUserId!: string;

  constructor(private authService: AuthService){
  }
  createdAt: string = '';
  canReply: boolean = false;
  canEdit: boolean = false;
  canDelete: boolean = false;
  reply!: Reply;
  replies!: Reply[];

  ngOnInit(): void {

    this.canReply = Boolean(this.currentUserId);
    this.canEdit = this.currentUserId === this.post.userId;
    this.canDelete = this.currentUserId === this.post.userId;
  }

  getPostsReplies(){

  }
}
