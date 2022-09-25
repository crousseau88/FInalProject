import { PostInterface } from './interfaces/post';
import { FormsModule, FormBuilder, ReactiveFormsModule } from '@angular/forms';
import { Post } from './models/post';
import { AppModule } from './app.module';
//import { PostModule } from './post.module';
import { PostService } from './services/post.service';
import { NgModule } from '@angular/core';
import { PostsComponent } from './components/posts/posts.component';
import { PostFormComponent } from './components/post-form/post-form.component';
import { PostComponent } from './components/post/post.component';
import { CommonModule } from '@angular/common';
// import { HttpClientModule } from '@angular/common/http';
// import { BrowserModule } from '@angular/platform-browser';
// import { AppRoutingModule } from './app-routing.module';

@NgModule({
  declarations: [PostComponent, PostFormComponent, PostsComponent],
  imports: [CommonModule, FormsModule, ReactiveFormsModule],
  exports: [PostsComponent, PostComponent, PostFormComponent],
  providers: [PostService],
})
export class PostModule {}
