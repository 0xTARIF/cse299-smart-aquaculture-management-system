# Smart Aquaculture Management System

### AI-Based Fish Disease Detection for Bangladesh

An **AI-powered mobile application** designed to help aquaculture farmers detect fish diseases quickly using smartphone images. The system uses **computer vision and deep learning** to identify fish and shrimp diseases and provides treatment guidance, disease tracking, and farm management tools.

---

## Table of Contents

- Project Overview
- Problem Statement
- Project Objectives
- Key Features
- Dataset
- Disease Classes
- Machine Learning Approach
- Machine Learning Pipeline
- Model Architecture
- System Architecture
- Technology Stack
- Expected Outcomes
- Project Timeline
- Project Structure
- Future Improvements
- References
- License

---

# Project Overview

Aquaculture plays a critical role in Bangladesh’s economy and food supply. However, fish diseases significantly reduce production and farmer income due to delayed diagnosis and lack of expert support.

This project introduces a **mobile AI-based disease detection system** that allows farmers to:

- Capture fish images using a smartphone
- Detect diseases using an AI model
- Receive treatment recommendations
- Track farm health and mortality
- Monitor disease outbreaks geographically

The goal is to **reduce fish mortality, improve farmer income, and modernize aquaculture management using AI**.

---

# Problem Statement

The fisheries sector contributes significantly to Bangladesh:

| Metric | Value |
|------|------|
| National GDP Contribution | ~3.5% |
| Agricultural GDP Contribution | ~25.7% |
| Animal Protein Supply | ~60% |

Despite its importance, farmers face several challenges:

- Limited access to aquaculture experts
- Delayed disease detection
- High mortality rates
- Lack of digital farm monitoring tools

Research indicates that **fish diseases cause approximately 18.5% annual income loss** in aquaculture farms.

---

# Project Objectives

The main objectives of this system are:

- Detect fish diseases using **AI image classification**
- Provide **real-time mobile diagnosis**
- Reduce disease-related losses through early detection
- Provide **AI-based aquaculture guidance**
- Enable **location-based disease monitoring**
- Offer **farm management tools for farmers**

---

# Key Features

## AI-Based Fish Disease Detection

Farmers capture an image of a fish using the mobile application.

The AI model analyzes the image and predicts whether the fish is:

- Healthy
- Affected by bacterial disease
- Fungal disease
- Parasitic disease
- Viral disease

The system provides **instant diagnosis within seconds**.

---

## Real-Time Mobile Detection

The trained deep learning model will be optimized using **TensorFlow Lite**, enabling it to run directly on Android devices with **low-latency inference (<1 second)**.

---

## Farmer Dashboard

The mobile application includes tools for farm management:

- Fish population tracking
- Mortality tracking
- Disease history monitoring
- Cost and profit estimation

---

## AI Chatbot Advisory System

An AI chatbot provides:

- Disease explanations
- Treatment recommendations
- Preventive farming practices
- Aquaculture guidance

---

## Location-Based Disease Reporting

Farmers can report disease cases with location data.

This allows the system to:

- Track disease outbreaks
- Identify regional disease trends
- Support improved aquaculture management decisions

---

# Dataset

The project uses the **BD Fish & Shrimp Disease Dataset**.

### Dataset Statistics

| Property | Value |
|--------|------|
| Total Images | 5,887 |
| Classes | 11 |
| Fish Classes | 7 |
| Shrimp Classes | 4 |

### Data Split

| Dataset | Percentage |
|-------|-------------|
| Training | 70% |
| Validation | 20% |
| Test | 10% |

### Image Properties

- RGB images
- Real aquaculture environments
- Variable resolution
- Resized to **224 × 224** during training

---

# Disease Classes

## Fish Disease Classes

| ID | Disease |
|---|---|
| 0 | Fish Bacterial Red Disease |
| 1 | Aeromoniasis |
| 2 | Bacterial Gill Disease |
| 3 | Fungal Disease (Saprolegniasis) |
| 4 | Healthy Fish |
| 5 | Parasitic Disease |
| 6 | Viral Disease (White Tail Disease) |

---

## Shrimp Disease Classes

| ID | Disease |
|---|---|
| 7 | Shrimp Black Gill |
| 8 | Healthy Shrimp |
| 9 | White Spot Syndrome Virus |
| 10 | White Spot Virus + Black Gill |

---

# Machine Learning Approach

This project is a **Multi-Class Image Classification problem** within **Computer Vision**.

The model learns patterns from labeled fish disease images and predicts the correct disease category.

---

# Machine Learning Pipeline

The ML workflow consists of the following stages:

1. Data Collection  
2. Data Preprocessing  
3. Data Augmentation  
4. Dataset Splitting  
5. Model Selection  
6. Model Training  
7. Model Evaluation  
8. Model Optimization  
9. Model Deployment  

---

# Model Architecture

The system uses **MobileNetV2 CNN** for disease classification.

### Reasons for Choosing MobileNetV2

- Lightweight architecture
- High performance on mobile devices
- Efficient inference speed
- Easy conversion to TensorFlow Lite

---

# System Architecture

The system consists of **three primary layers**.

### Mobile Application Layer
- Flutter Android application
- Camera image capture
- Farmer dashboard interface

### AI Detection Layer
- Image preprocessing
- CNN inference using MobileNetV2
- TensorFlow Lite model execution

### Backend Layer
- REST API services
- Database storage
- Analytics dashboard
- Disease reporting system
- AI chatbot integration

---

# Technology Stack

## Mobile Application

- Flutter
- Dart
- Camera API
- TensorFlow Lite

## AI & Machine Learning

- Python
- TensorFlow
- Keras
- MobileNetV2 CNN

## Backend

- FastAPI or Node.js
- REST API services

## Database

- Firebase Firestore
- PostgreSQL

## Chatbot System

- OpenAI API or LLM API
- Rasa NLP framework
- Aquaculture knowledge base

---

# Expected Outcomes

The system aims to achieve:

- **~90% disease detection accuracy**
- **<1 second mobile inference time**
- **10–20% reduction in disease-related losses**
- Improved farmer income
- Better disease outbreak monitoring

---

# Project Timeline

| Week | Task |
|----|----|
| 1 | Dataset analysis |
| 2 | Data preprocessing |
| 3 | Data augmentation |
| 4 | CNN model development |
| 5 | Model training |
| 6 | Mobile app development |
| 7 | Backend integration |
| 8 | Testing and deployment |

---

# Project Structure

Smart-Aquaculture-Management-System
│
├── dataset
├── ml-model
│ ├── training
│ ├── preprocessing
│ └── evaluation
│
├── mobile-app
├── backend
├── docs
└── README.md


---

# Future Improvements

Potential future enhancements include:

- Expanding dataset size
- Adding more disease categories
- Improving model accuracy
- Real-time farm analytics
- Multilingual farmer interface
- Integration with IoT water quality sensors

---

# References

1. Islam, S. et al. Fish Production of Bangladesh and Impact on GDP, 2023  
2. Ghose, B. Fisheries and Aquaculture in Bangladesh, 2014  
3. Mamun Haque, M.I. Aquaculture Status and Disease Analysis in Bangladesh, 2022  
4. Vasumathi, A. et al. Fish Disease Detection using Machine Learning, 2024  
5. Nivin K. S., Hebri D. Efficient Fish Disease Detection in Aquaculture, 2025

---

# License

This project is licensed under the **MIT License**.
