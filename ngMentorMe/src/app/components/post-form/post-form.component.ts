import { Post } from './../../models/post';
import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';

@Component({
  selector: 'app-post-form',
  templateUrl: './post-form.component.html',
  styleUrls: ['./post-form.component.css'],
})
export class PostFormComponent implements OnInit {
  @Input() submitLabel!: string;
  @Input() hasCancelButton: boolean = false;
  @Input() initialText: string = '';
  @Output()
  handleSubmit = new EventEmitter<string>();
  form!: FormGroup;

  constructor(private fb: FormBuilder) {}

  ngOnInit(): void {
    this.form = this.fb.group({
      title: [this.initialText, Validators.required],
      subject: [this.initialText, Validators.required],
    });
  }

  onSubmit(): void {
    this.handleSubmit.emit(this.form.value.subject);
    this.form.reset();
  }
}
