import '../assets.dart';
import '../models/activity_model.dart';
import '../models/destination_model.dart';
import '../models/hotel_model.dart';

final List<Hotel> hotels = [
  Hotel(
    imageUrl: Asset.hotel1,
    name: "Hotel1",
    address: '14 Entebbe',
    price: 120,
  ),
  Hotel(
    imageUrl: Asset.hotel2,
    name: "Hotel2",
    address: 'Hoima',
    price: 120,
  ),
  Hotel(
    imageUrl: Asset.hotel3,
    name: "Hotel3",
    address: 'Hoima',
    price: 18,
  ),
  Hotel(
    imageUrl: Asset.hotel4,
    name: "Hotel4",
    address: 'Mbale',
    price: 20,
  ),
  Hotel(
    imageUrl: Asset.hotel5,
    name: "Hotel5",
    address: 'Entebbe',
    price: 450,
  ),
  Hotel(
    imageUrl: Asset.hotel6,
    name: "Hotel6",
    address: 'Mbarara',
    price: 120,
  ),
  Hotel(
    imageUrl: Asset.hotel7,
    name: "Hotel7",
    address: 'Kasese',
    price: 220,
  ),
  Hotel(
    imageUrl: Asset.hotel8,
    name: "Hotel8",
    address: 'Kabale',
    price: 240,
  ),
  Hotel(
    imageUrl: Asset.hotel9,
    name: "Hotel9",
    address: 'Kabale',
    price: 150,
  ),
];

final List<Activity> activities = [
  Activity(
    imageUrl: Asset.dest1,
    name: 'Walking tour and cable riding',
    type: 'Sightseeing Tour',
    startTimes: ['9:00 am', '11:45 am'],
    rating: 4,
    price: 49,
  ),
  Activity(
    imageUrl: Asset.dest2,
    name: 'Walking tour and cable riding',
    type: 'Sightseeing Tour',
    startTimes: ['9:45 am', '11:45 am'],
    rating: 5,
    price: 24,
  ),
  Activity(
    imageUrl: Asset.dest3,
    name: 'Walking tour and cable riding',
    type: 'Sightseeing Tour',
    startTimes: ['10:00 am', '12:00 noon'],
    rating: 3,
    price: 9,
  ),
  Activity(
    imageUrl: Asset.dest4,
    name: 'Walking tour and cable riding',
    type: 'Sightseeing Tour',
    startTimes: ['9:00 am', '11:00 am'],
    rating: 5,
    price: 120,
  ),
  Activity(
    imageUrl: Asset.dest5,
    name: 'Walking tour and cable riding',
    type: 'Sightseeing Tour',
    startTimes: ['9:30 am', '10:30 am'],
    rating: 5,
    price: 150,
  ),
  Activity(
    imageUrl: Asset.dest6,
    name: 'Walking tour and cable riding',
    type: 'Sightseeing Tour',
    startTimes: ['9:00 am', '11:00 am'],
    rating: 4,
    price: 80,
  ),
  Activity(
    imageUrl: Asset.dest7,
    name: 'Walking tour and cable riding',
    type: 'Sightseeing Tour',
    startTimes: ['1:00 pm', '2:45 pm'],
    rating: 5,
    price: 50,
  ),
  Activity(
    imageUrl: Asset.dest8,
    name: 'Walking tour and cable riding',
    type: 'Sightseeing Tour',
    startTimes: ['11:00 am', '1:30 pm'],
    rating: 5,
    price: 45,
  ),
  Activity(
    imageUrl: Asset.dest9,
    name: 'Walking tour and cable riding',
    type: 'Sightseeing Tour',
    startTimes: ['11:00 am', '2:00 pm'],
    rating: 4,
    price: 230,
  ),
];

final List<Destination> destinations = [
  Destination(
    imageUrl: Asset.dest1,
    city: 'Entebbe',
    country: 'Uganda',
    description: 'A place gifted by mother nature beyond imagination.',
    activities: activities,
  ),
  Destination(
    imageUrl: Asset.dest2,
    city: 'Kabale',
    country: 'Uganda',
    description: 'A place gifted by mother nature beyond imagination.',
    activities: activities,
  ),
  Destination(
    imageUrl: Asset.dest3,
    city: 'Mbale',
    country: 'Uganda',
    description: 'A place gifted by mother nature beyond imagination.',
    activities: activities,
  ),
  Destination(
    imageUrl: Asset.dest4,
    city: 'Entebbe',
    country: 'Uganda',
    description: 'A place gifted by mother nature beyond imagination.',
    activities: activities,
  ),
  Destination(
    imageUrl: Asset.dest5,
    city: 'Hoima',
    country: 'Uganda',
    description: 'A place gifted by mother nature beyond imagination.',
    activities: activities,
  ),
  Destination(
    imageUrl: Asset.dest6,
    city: 'Kasese',
    country: 'Uganda',
    description: 'A place gifted by mother nature beyond imagination.',
    activities: activities,
  ),
  Destination(
    imageUrl: Asset.dest7,
    city: 'Hoima',
    country: 'Uganda',
    description: 'A place gifted by mother nature beyond imagination.',
    activities: activities,
  ),
  Destination(
    imageUrl: Asset.dest8,
    city: 'Mbarara',
    country: 'Uganda',
    description: 'A place gifted by mother nature beyond imagination.',
    activities: activities,
  ),
  Destination(
    imageUrl: Asset.dest9,
    city: 'Bushenyi',
    country: 'Uganda',
    description: 'A place gifted by mother nature beyond imagination.',
    activities: activities,
  ),
  Destination(
    imageUrl: Asset.dest1,
    city: 'Entebbe',
    country: 'Uganda',
    description: 'A place gifted by mother nature beyond imagination.',
    activities: activities,
  ),
];
