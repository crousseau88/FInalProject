import { AuthService } from './../../services/auth.service';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { PostInterface } from './../../interfaces/post';
import { PostService } from './../../services/post.service';
import { Component, Input, OnInit } from '@angular/core';
import { Post } from 'src/app/models/post';
import { ActivatedRoute, Router } from '@angular/router';
import { User } from 'src/app/models/user';
import { Reply } from 'src/app/models/reply';

@Component({
  selector: 'app-posts',
  templateUrl: './posts.component.html',
  styleUrls: ['./posts.component.css'],
  inputs: ['post'],
})
export class PostsComponent implements OnInit {
  posts: PostInterface[] = [];
  @Input() post!: PostInterface;
  @Input() userId!: string;
  selected: PostInterface | null = null;
  loggedInUser: User | null = null;
  submittedPost!: PostInterface;
  currentUserId: any  = this.loggedInUser?.id;

  constructor(
    private postService: PostService,
    private route: ActivatedRoute,
    private router: Router,
    private http: HttpClient,
    private authService: AuthService
  ) {}

  ngOnInit(): void {
    this.getAllPosts();
    this.authService.getLoggedInUser().subscribe({
      next: (user) => {
        this.loggedInUser = user;
      },
      error: (err) => {
        console.error('Error retrieving user');
        console.error(err);
      },
    });
  }

  getAllPosts() {
    return this.postService.index().subscribe({
      next: (data) => {
        this.posts = data;
      },
      error: (err) => {
        console.error('PostComponent.reload(): error loading posts:');
        console.error(err);
      },
    });
  }

  addPost(post: any): void {
    //console.log('Posted Comment is: ', text, postId);
    // this.submittedPost.subject = subject;
    console.log('******************SUBJECT********************');
    console.log('POST');
    this.postService.createPost(post).subscribe((createdPost) => {
      this.posts = [...this.posts, createdPost];
    });
  }

  getReplies(postId: string): PostInterface[] {
    return this.posts
      .filter((reply) => reply.id === postId)
      .sort(
        (a, b) =>
          new Date(a.created).getTime() - new Date(b.created).getTime()
      );
  }


  // reload() {
  //   this.postService.index().subscribe({
  //     next: (data) => {
  //       this.posts = data;
  //     },
  //     error: (err) => {
  //       console.error('PostComponent.reload(): error loading posts:');
  //       console.error(err);
  //     },
  //   });
  // }
}
