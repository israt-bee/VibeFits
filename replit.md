# VibeFits E-commerce Platform

## Overview

VibeFits is a modern e-commerce platform designed for fashion retail in Bangladesh, featuring a curated collection of dresses, makeup, watches, and shoes. The application uses a mood-based filtering system that allows customers to shop by "fashion vibes" for a personalized shopping experience.

**Current Status**: Fully functional with authentication working, 14 sample products loaded, and all core features operational. Currently using memory storage with plans to migrate to PostgreSQL for persistence.

## User Preferences

Preferred communication style: Simple, everyday language.

## System Architecture

### Frontend Architecture
- **Framework**: React 18 with TypeScript
- **Build Tool**: Vite for fast development and optimized builds
- **Routing**: Wouter for lightweight client-side routing
- **Styling**: Tailwind CSS with shadcn/ui component library
- **State Management**: TanStack Query for server state management
- **Forms**: React Hook Form with Zod validation

### Backend Architecture
- **Runtime**: Node.js with Express.js framework
- **Language**: TypeScript with ES modules
- **Database**: PostgreSQL with Drizzle ORM
- **Authentication**: Replit Auth with OpenID Connect
- **Session Management**: Express sessions with PostgreSQL storage

### Key Components

#### Database Layer
- **ORM**: Drizzle ORM for type-safe database operations
- **Schema**: Shared schema definitions in TypeScript
- **Migrations**: Drizzle Kit for database migrations
- **Connection**: Neon serverless PostgreSQL with connection pooling

#### Authentication System
- **Provider**: Replit Auth integration
- **Strategy**: OpenID Connect with Passport.js
- **Session Storage**: PostgreSQL-backed sessions with TTL support
- **User Management**: Automatic user creation/updates from auth claims

#### API Design
- **REST**: RESTful API endpoints with Express routing
- **Validation**: Zod schemas for request/response validation
- **Error Handling**: Centralized error handling with proper HTTP status codes
- **Logging**: Request/response logging with performance metrics

#### UI Components
- **Design System**: shadcn/ui components with Radix UI primitives
- **Responsive Design**: Mobile-first approach with Tailwind CSS
- **Animations**: CSS transitions and transforms for smooth interactions
- **Accessibility**: ARIA-compliant components with keyboard navigation

## Data Flow

1. **User Authentication**: 
   - Users authenticate via Replit Auth
   - Session data stored in PostgreSQL
   - User profile synced from auth claims

2. **Product Discovery**:
   - Products filtered by category, fashion modes, and search
   - Real-time filtering with debounced search
   - Pagination and sorting capabilities

3. **Shopping Cart**:
   - Cart items stored in database per user
   - Real-time updates with optimistic UI
   - Quantity adjustments and item removal

4. **Order Processing**:
   - Order creation with cart items
   - Order status tracking
   - Admin order management

5. **Admin Operations**:
   - Product CRUD operations
   - Order management
   - Dashboard statistics

## External Dependencies

### Database
- **Neon**: Serverless PostgreSQL hosting
- **Connection**: WebSocket-based connections for serverless compatibility

### Authentication
- **Replit Auth**: OAuth2/OpenID Connect provider
- **Session Storage**: PostgreSQL with connect-pg-simple

### UI Libraries
- **Radix UI**: Headless UI components
- **Lucide React**: Icon library
- **Tailwind CSS**: Utility-first CSS framework
- **shadcn/ui**: Pre-built component library

### Development Tools
- **Vite**: Build tool and dev server
- **TypeScript**: Type safety and developer experience
- **ESLint/Prettier**: Code quality and formatting

## Deployment Strategy

### Production Build
- **Frontend**: Vite builds optimized static assets
- **Backend**: esbuild bundles server code for Node.js
- **Database**: Drizzle migrations applied on deployment

### Environment Configuration
- **DATABASE_URL**: PostgreSQL connection string
- **SESSION_SECRET**: Session encryption key
- **REPLIT_DOMAINS**: Auth domain configuration
- **ISSUER_URL**: OpenID Connect issuer endpoint

### File Structure
```
/client          # React frontend
/server          # Express backend
/shared          # Shared TypeScript definitions
/migrations      # Database migrations
/dist            # Production build output
```

### Key Features
- **Fashion Vibes**: Mood-based product filtering system
- **Multi-category**: Dresses, makeup, watches, shoes
- **Real-time Cart**: Instant cart updates with optimistic UI
- **Admin Panel**: Product and order management
- **Responsive Design**: Mobile-optimized shopping experience
- **Search & Filter**: Advanced product discovery
- **Order Management**: Complete order lifecycle tracking

The architecture prioritizes type safety, performance, and maintainability while providing a smooth user experience for fashion e-commerce in the Bangladesh market.