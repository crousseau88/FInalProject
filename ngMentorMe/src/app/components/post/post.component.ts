import { Component, Input, OnInit } from '@angular/core';
import { PostInterface } from 'src/app/interfaces/post';
import { Post } from 'src/app/models/post';

@Component({
  selector: 'app-post',
  templateUrl: './post.component.html',
  styleUrls: ['./post.component.css'],
})
export class PostComponent {
  @Input() post!: PostInterface;

  constructor() {}

  ngOnInit(): void {}
}
