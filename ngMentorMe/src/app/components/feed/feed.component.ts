import { PostService } from './../../services/post.service';
import { Component, OnInit } from '@angular/core';
import { Post } from 'src/app/models/post';
import { Reply } from 'src/app/models/reply';
import { formatCurrency } from '@angular/common';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-feed',
  templateUrl: './feed.component.html',
  styleUrls: ['./feed.component.css'],
})
export class FeedComponent implements OnInit {
  posts: Post[] = [];
  newPostReplies: Reply[] = [];
  newPost: Post = new Post();
  user: User | null = null;
  newComment: Reply = new Reply();

  constructor(private auth: AuthService, private postServ: PostService) {}

  ngOnInit(): void {
    this.auth.getLoggedInUser().subscribe({
      next: (user) => {
        this.loadPosts();
        this.user = user;
      },
      error: (err) => {
        console.error('Error retrieving user');
        console.error(err);
      },
    });
  }
  loadPosts() {
    this.postServ.getAllRealPosts().subscribe({
      next: (posts) => {
        this.posts = posts.sort(
          (a, b) =>
            new Date(b.created).getTime() - new Date(a.created).getTime()
        );
        this.newPostReplies = [];
        for (let i = 0; i < this.posts.length; i++) {
          this.newPostReplies.push(new Reply());
        }
      },
      error: (err) => {
        console.error('Error retrieving posts: ' + err);
      },
    });
  }
  createNewPost(post: Post) {
    this.postServ.create(post).subscribe({
      next: (post) => {
        this.posts.push(post);
        this.loadPosts();
      },
      error: (err) => {
        console.error('Error creating post: ' + err);
      },
    });
  }

  deletePost(postId: number) {
    this.postServ.delete(postId).subscribe({
      next: (post) => {
        this.loadPosts();
      },
      error: (err) => {
        console.error('Error creating post: ' + err);
      },
    });
  }

  reload() {
    window.location.reload();
  }

  createNewComment(comment: Reply, postId: number) {
    this.postServ.createCommentOnPost(postId, comment).subscribe({
      next: (comment) => {
        // this.reload();
        this.loadPosts();
      },
      error: (err) => {
        console.error('Error creating post: ' + err);
      },
    });
  }

  deleteComment(postId: number, commentId: number) {
    this.postServ.deleteCommentOnPost(postId, commentId).subscribe({
      next: (comment) => {
        this.loadPosts();
      },
      error: (err) => {
        console.error('Error deleteing comment on post: ' + err);
      },
    });
  }
}
