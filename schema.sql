-- Smart Parking System - Database Schema
-- This file defines all tables used by the system

-- Users table: stores registered users and admins
CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,          -- stored as hashed password
    role TEXT NOT NULL DEFAULT 'user', -- 'user' or 'admin'
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Parking slots table: each row is one physical parking slot
CREATE TABLE IF NOT EXISTS parking_slots (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    slot_number TEXT UNIQUE NOT NULL,  -- e.g. "A1", "B3"
    location TEXT NOT NULL,            -- e.g. "Block A - Ground Floor"
    status TEXT NOT NULL DEFAULT 'available',  -- 'available' or 'occupied'
    vehicle_type TEXT NOT NULL DEFAULT 'car',  -- 'car', 'bike', 'truck'
    rate_per_hour REAL NOT NULL DEFAULT 30.0   -- cost in ₹ per hour
);

-- Bookings table: each row is one parking session
CREATE TABLE IF NOT EXISTS bookings (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    slot_id INTEGER NOT NULL,
    vehicle_number TEXT NOT NULL,       -- e.g. "KA01AB1234"
    start_time DATETIME NOT NULL,       -- when the booking started
    end_time DATETIME,                  -- filled when user exits (NULL if active)
    duration_minutes INTEGER,           -- calculated on exit
    total_cost REAL,                    -- calculated on exit
    status TEXT NOT NULL DEFAULT 'active', -- 'active' or 'completed'
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (slot_id) REFERENCES parking_slots(id)
);
