import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { PostInterface } from './../../interfaces/post';
import { PostService } from './../../services/post.service';
import { Component, Input, OnInit } from '@angular/core';
import { Post } from 'src/app/models/post';
import { ActivatedRoute, Router } from '@angular/router';

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
  constructor(
    private postService: PostService,
    private route: ActivatedRoute,
    private router: Router,
    private http: HttpClient
  ) {}

  ngOnInit(): void {
    this.getAllPosts();
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

  addPost({ text, postId }: { text: string; postId: string | null }): void {
    console.log('Posted Comment is: ', text, postId);
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
