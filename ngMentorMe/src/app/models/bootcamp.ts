import { BootcampTech } from "./bootcamp-tech";

export class Bootcamp {
  id: number = 0;
  name: string = '';
  website: string = '';
  imageUrl: string = '';
  lengthWeeks: number = 0;
  description: string = '';
  bootcampTech: BootcampTech[] = [];

  constructor(
  id: number = 0,
  name: string = '',
  website: string = '',
  imageUrl: string = '',
  lengthWeeks: number = 0,
  description: string = '',
  bootcampTech: BootcampTech[] = []
  ) {
    this.id = id;
    this.name = name;
    this.website = website;
    this.imageUrl = imageUrl;
    this.lengthWeeks = lengthWeeks;
    this.description = description;
    this.bootcampTech = bootcampTech;
  }

}
