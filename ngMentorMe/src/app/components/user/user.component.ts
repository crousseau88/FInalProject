import { UserService } from '../../services/user.service';
import { NgIf } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { User } from 'src/app/models/user';
import { ActivatedRoute, Router } from '@angular/router';

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

    editUser: User | null = null;

  constructor(
    private userService: UserService,
    private route: ActivatedRoute,
    private router:  Router
  ) { }

  reload(): void {
    this.userService.index().subscribe({
      next: (users) => {
        this.users = users;
      },
      error: (problem) => {
        console.error('UserListHttpComponent.reload(): error loading users:');
        console.error(problem);
      },
    });
  }

  ngOnInit(): void {
    let username = this.route.snapshot.paramMap.get('username');
    if(username) {
      this.userService.show(username).subscribe({
        next: (user) => {
          this.user = user;
        },
        error: (err) => {
          console.error('Error retrieving user');
          console.error(err);
        }
      });
  }
  this.reload();
}

}
