import { AuthService } from './../../services/auth.service';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { PostInterface } from './../../interfaces/post';
import { PostService } from './../../services/post.service';
import { Component, Input, OnInit } from '@angular/core';
import { Post } from 'src/app/models/post';
import { ActivatedRoute, Router } from '@angular/router';
import { User } from 'src/app/models/user';

@Component({
  selector: 'app-posts',
  templateUrl: './posts.component.html',
  styleUrls: ['./posts.component.css'],
  inputs: ['post'],
})
export class PostsComponent implements OnInit {
  currentUserId: number | undefined;
  posts: PostInterface[] = [];
  @Input() post!: PostInterface;
  selected: PostInterface | null = null;
  loggedInUser: User | null = null;
  submittedPost!: PostInterface;

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

  addPost({
    subject,
    text,
    postId,
  }: {
    subject: any;
    text: string;
    postId: string | null;
  }) {
    //console.log('Posted Comment is: ', text, postId);
    this.submittedPost.subject = subject;
    console.log('******************SUBJECT********************');
    console.log(subject);
    this.submittedPost.text = text;
    console.log('****************TEXT**********************');
    console.log(text);
    return this.postService.createPost(this.submittedPost, postId).subscribe({
      next: (data) => {
        this.submittedPost = data;
      },
      error: (err) => {
        console.error('PostComponent.reload(): error loading posts:');
        console.error(err);
      },
    });
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
