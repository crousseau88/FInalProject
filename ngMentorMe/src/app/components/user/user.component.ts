import { NgIf } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { User } from 'src/app/models/user';

@Component({
  selector: 'app-user',
  templateUrl: './user.component.html',
  styleUrls: ['./user.component.css']
})
export class UserComponent implements OnInit {
    user: User | null = null;

    users: User[] = []; //mentors/mentees

    selected: User | null = null;

    newUser: User = new User();

    allUsers: User[]= [];//display all users

  constructor() { }

  ngOnInit(): void {
  }

}
