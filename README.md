# 🥟 Chinese Restaurant Ranking App

A SwiftUI-based iOS application for tracking and ranking your favorite Chinese restaurants with detailed ratings, photos, and personal notes.

## 📱 Features

### Restaurant Management
- **Add New Restaurants** - Create entries with name, address, cuisine type, and photos
- **Detailed Ratings** - Rate restaurants across 4 categories:
  - 🍜 Food Quality
  - 👨‍🍳 Service
  - 🕯️ Ambiance
  - 💰 Value
- **Visual Rating Display** - Color-coded progress bars with emoji indicators
- **Photo Gallery** - Upload and manage restaurant photos using the native Photos Picker

### Favorite Dishes
- **Track Favorites** - Add and display your favorite dishes from each restaurant
- **Flexible Grid Layout** - Dishes displayed in an adaptive grid that flows naturally
- **Edit/View Modes** - Toggle between editing and viewing modes

### Restaurant Cards
- **Beautiful Cards** - Eye-catching cards with restaurant photos, ratings, and badges
- **Category Badges** - Cuisine type indicators (Cantonese, Szechuan, etc.)
- **Quick Overview** - Star ratings and key metrics at a glance

### Personal Notes
- **Custom Notes** - Add personal comments and observations about each restaurant
- **Multi-line Input** - Dedicated text area for longer notes

## 🛠️ Technical Stack

### Frontend
- **SwiftUI** - Modern declarative UI framework
- **iOS 16+** - Targeting latest iOS features
- **MVVM Architecture** - Clean separation of concerns
- **ObservableObject Pattern** - Reactive state management
- **Environment Objects** - Shared data across views

### Key Components
```
RestaurantCard          - Main card component for restaurant display
RestaurantDetailView    - Detailed view with full information
AddRestaurantView       - Form for adding new restaurants
RatingRow              - Reusable rating display component
FavoriteDishes         - Grid layout for favorite dishes
PhotoPicker            - Native iOS photo selection
InputRow               - Custom text input component
```

### Data Management
- **RestaurantManager** - ObservableObject managing restaurant list
- **Restaurant Model** - Codable struct with Identifiable conformance
- **@State & @Binding** - Local and shared state management
- **Image Storage** - Photos stored as Data for persistence

## 🎨 UI/UX Highlights

- **Subtle Gradients** - Warm, inviting background colors
- **Consistent Styling** - Unified design language throughout
- **Smooth Scrolling** - Optimized ScrollViews and LazyVGrids
- **Interactive Elements** - Floating action buttons, dismissible photos
- **Dark Mode Support** - Adaptive colors for light/dark themes
- **SF Symbols** - Native iOS iconography

## 🚀 Getting Started

### Prerequisites
- Xcode 15.0+
- iOS 16.0+
- Swift 5.9+

### Installation
1. Clone the repository
```bash
git clone https://github.com/yourusername/chinese-restaurant-ranking.git
```

2. Open the project in Xcode
```bash
cd chinese-restaurant-ranking
open ChineseFoodRanking.xcodeproj
```

3. Build and run on simulator or device

## 📂 Project Structure

```
ChineseFoodRanking/
├── Models/
│   └── Restaurant.swift
├── ViewModels/
│   └── RestaurantManager.swift
├── Views/
│   ├── ContentView.swift
│   ├── RestaurantCard.swift
│   ├── RestaurantDetailView.swift
│   ├── AddRestaurantView.swift
│   └── Components/
│       ├── RatingRow.swift
│       ├── FavoriteDishes.swift
│       ├── PhotoPicker.swift
│       ├── InputRow.swift
│       └── Badge.swift
└── Assets.xcassets/
```

## 🔮 Roadmap

### Phase 1 - Core Features (Current)
- [x] Basic restaurant CRUD operations
- [x] Rating system with visual feedback
- [x] Photo management
- [x] Favorite dishes tracking
- [x] Personal notes

### Phase 2 - Backend Integration (Planned)
- [ ] **Java Spring Boot Backend** - RESTful API for data persistence
- [ ] User authentication and profiles
- [ ] Cloud photo storage
- [ ] Data synchronization across devices
- [ ] Backup and restore functionality

### Phase 3 - Enhanced Features (Future)
- [ ] Search and filtering
- [ ] Sort by ratings, cuisine type, etc.
- [ ] Map integration for restaurant locations
- [ ] Share restaurants with friends
- [ ] Export ratings as PDF/image
- [ ] Multiple photo support per restaurant
- [ ] Restaurant visit history tracking

### Phase 4 - Social Features (Future)
- [ ] Follow other users
- [ ] Public restaurant reviews
- [ ] Recommendations based on preferences
- [ ] Restaurant wishlists

## 🧪 Learning Journey

This project was built as a learning experience while mastering SwiftUI. Key concepts explored:
- Component composition and reusability
- State management patterns (@State, @Binding, @EnvironmentObject)
- Custom components with flexible APIs
- Layout systems (VStack, HStack, ZStack, LazyVGrid)
- Navigation and sheets
- Image handling and PhotosPicker
- Preview system for rapid development

## 🤝 Contributing

This is a personal learning project, but suggestions and feedback are welcome! Feel free to open issues or submit pull requests.

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 📧 Contact

Damian Brudkowski - [Your Email/LinkedIn]

---

⭐ If you found this project helpful for learning SwiftUI, consider giving it a star!

## 🙏 Acknowledgments

- Thanks to the SwiftUI community for tutorials and inspiration
- SF Symbols for beautiful, native icons
- Claude AI for guidance during development

---

**Note:** This is an educational project built to learn iOS development with SwiftUI. The backend implementation with Java/Spring Boot is planned for future development to create a full-stack application.
