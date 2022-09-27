import { Component, OnInit } from '@angular/core';
import {  ViewChild } from '@angular/core';
import { NgbCarousel, NgbSlideEvent, NgbSlideEventSource } from '@ng-bootstrap/ng-bootstrap';
import { Bootcamp } from 'src/app/models/bootcamp';
import { BootcampService } from 'src/app/services/bootcamp.service';
@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {
  login(arg0: any) {
    throw new Error('Method not implemented.');
  }
  loginUser: any;

  constructor(
    private bootcampServ: BootcampService
  ) { }

  ngOnInit(): void {
    this.getAllBootcamps();
    this.loadImages();

  }
  images: string [] = []; //add our images array instead of the example

  paused = false;
  unpauseOnArrow = false;
  pauseOnIndicator = false;
  pauseOnHover = true;
  pauseOnFocus = true;
  allBootcamps: Bootcamp [] = [];
  selectedBootcamp: Bootcamp | null = null;

  @ViewChild('carousel', {static : true}) carousel: NgbCarousel | undefined;

  togglePaused() {
    if (this.paused) {
      this.carousel?.cycle();
    } else {
      this.carousel?.pause();
    }
    this.paused = !this.paused;
  }

  onSlide(slideEvent: NgbSlideEvent) {
    if (this.unpauseOnArrow && slideEvent.paused &&
      (slideEvent.source === NgbSlideEventSource.ARROW_LEFT || slideEvent.source === NgbSlideEventSource.ARROW_RIGHT)) {
      this.togglePaused();
    }
    if (this.pauseOnIndicator && !slideEvent.paused && slideEvent.source === NgbSlideEventSource.INDICATOR) {
      this.togglePaused();
    }
  }

  getAllBootcamps() {
    this.bootcampServ.index().subscribe({
      next: (data) => {
        this.allBootcamps = data;
      },
      error: (err) => {
        console.error('Error retrieving bootcamps');
        console.error(err);
      }
    })
  }

  loadImages(): string[] {
    this.allBootcamps.forEach((bootcamp) => {
      this.images.push(bootcamp.imageUrl);
    });
    return this.images;
  }

  displayBootcamp(bootcamp: Bootcamp) {
    this.selectedBootcamp = bootcamp;
  }
}
