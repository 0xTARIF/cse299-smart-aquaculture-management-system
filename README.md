\# Smart Aquaculture Management System  

\### AI-Based Fish Disease Detection for Bangladesh



An \*\*AI-powered mobile application\*\* designed to help aquaculture farmers detect fish diseases quickly using smartphone images. The system uses \*\*computer vision and deep learning\*\* to identify fish and shrimp diseases and provides treatment guidance, disease tracking, and farm management tools.



---



\# Project Overview



Aquaculture plays a critical role in Bangladesh’s economy and food supply. However, fish diseases significantly reduce production and farmer income due to delayed diagnosis and lack of expert support.



This project introduces a \*\*mobile AI-based disease detection system\*\* that allows farmers to:



\- Capture fish images using a smartphone

\- Detect diseases using an AI model

\- Receive treatment recommendations

\- Track farm health and mortality

\- Monitor disease outbreaks geographically



The goal is to \*\*reduce fish mortality, improve farmer income, and modernize aquaculture management using AI\*\*.



---



\# Problem Statement



The fisheries sector contributes significantly to Bangladesh:



\- \*\*3.5% of national GDP\*\*

\- \*\*~25.7% of agricultural GDP\*\*

\- \*\*~60% of animal protein intake\*\*



Despite its importance, farmers face several challenges:



\- Lack of access to aquaculture experts

\- Delayed disease detection

\- High mortality rates

\- Limited digital monitoring tools



Studies indicate that \*\*fish diseases cause approximately 18.5% annual income loss\*\* in aquaculture farms.



---



\# Project Objectives



The primary objectives of this system are:



\- Detect fish diseases using \*\*AI image classification\*\*

\- Provide \*\*real-time disease diagnosis via mobile phone\*\*

\- Reduce disease-related losses through early detection

\- Provide \*\*aquaculture guidance via AI chatbot\*\*

\- Enable \*\*location-based disease monitoring\*\*

\- Offer \*\*farm management tools for farmers\*\*



---



\# Key Features



\## AI-Based Fish Disease Detection



Farmers capture an image of a fish using the mobile application.



The AI model analyzes the image and predicts whether the fish is:



\- Healthy

\- Affected by bacterial disease

\- Fungal disease

\- Parasitic disease

\- Viral disease



The system provides \*\*instant diagnosis within seconds\*\*.



---



\## Real-Time Mobile Detection



The trained deep learning model will be optimized using \*\*TensorFlow Lite\*\*, enabling the model to run directly on Android devices with \*\*low latency inference (<1 second)\*\*.



---



\## Farmer Dashboard



The mobile application includes a dashboard that allows farmers to manage farm data:



\- Fish population tracking

\- Mortality tracking

\- Disease history monitoring

\- Cost and profit estimation



---



\## AI Chatbot Advisory System



An integrated AI chatbot will provide farmers with:



\- Fish disease information

\- Treatment suggestions

\- Preventive measures

\- Aquaculture best practices



The chatbot can be built using:



\- LLM APIs or

\- Rasa NLP system



---



\## Location-Based Disease Reporting



Farmers can report disease cases with location data.



This allows the system to:



\- Monitor disease outbreaks

\- Identify regional disease patterns

\- Support better aquaculture management decisions



---



\# Dataset



The project uses the \*\*BD Fish \& Shrimp Disease Dataset\*\*.



\### Dataset Source

HuggingFace Dataset Repository



\### Dataset Statistics



| Property | Value |

|--------|------|

| Total Images | 5,887 |

| Classes | 11 |

| Fish Classes | 7 |

| Shrimp Classes | 4 |



\### Data Split



| Dataset | Percentage |

|-------|-------------|

| Training | 70% |

| Validation | 20% |

| Test | 10% |



\### Image Properties



\- RGB images

\- Real aquaculture environments

\- Variable resolution

\- Resized to \*\*224 × 224\*\* during training



---



\# Disease Classes



\## Fish Disease Classes



| ID | Disease |

|---|---|

| 0 | Fish Bacterial Red Disease |

| 1 | Aeromoniasis |

| 2 | Bacterial Gill Disease |

| 3 | Fungal Disease (Saprolegniasis) |

| 4 | Healthy Fish |

| 5 | Parasitic Disease |

| 6 | Viral Disease (White Tail Disease) |



\## Shrimp Disease Classes



| ID | Disease |

|---|---|

| 7 | Shrimp Black Gill |

| 8 | Healthy Shrimp |

| 9 | White Spot Syndrome Virus |

| 10 | White Spot Virus + Black Gill |



---



\# Machine Learning Approach



The project is a \*\*Multi-Class Image Classification problem\*\* under \*\*Computer Vision\*\*.



The model learns from labeled fish disease images to classify disease categories.



---



\# Machine Learning Pipeline



The ML pipeline consists of the following steps:



1\. Data Collection  

2\. Data Preprocessing  

3\. Data Augmentation  

4\. Dataset Splitting  

5\. Model Selection  

6\. Model Training  

7\. Model Evaluation  

8\. Model Optimization  

9\. Model Deployment  



---



\# Model Architecture



The project uses \*\*MobileNetV2 CNN\*\* for disease detection.



Reasons for choosing MobileNetV2:



\- Lightweight architecture

\- High accuracy

\- Suitable for mobile devices

\- Efficient TensorFlow Lite deployment



---



\# System Architecture



The system consists of \*\*three main layers\*\*.



\### Mobile Application Layer

\- Flutter Android application

\- Camera image capture

\- Farmer dashboard



\### AI Detection Layer

\- Image preprocessing

\- CNN inference using MobileNetV2

\- TensorFlow Lite model execution



\### Backend Layer

\- REST API services

\- Database management

\- Analytics dashboard

\- Disease reporting system

\- AI chatbot integration



---



\# Technology Stack



\## Mobile Application

\- Flutter

\- Dart

\- Camera API

\- TensorFlow Lite



\## AI \& Machine Learning

\- Python

\- TensorFlow

\- Keras

\- MobileNetV2 CNN



\## Backend

\- FastAPI or Node.js

\- REST APIs



\## Database

\- Firebase Firestore

\- PostgreSQL



\## AI Chatbot

\- OpenAI API / LLM API

\- Rasa NLP

\- Aquaculture knowledge base



---



\# Expected Outcomes



The system aims to achieve:



\- \*\*~90% disease detection accuracy\*\*

\- \*\*<1 second mobile inference time\*\*

\- \*\*10–20% reduction in disease losses\*\*

\- Improved farmer income

\- Better disease outbreak monitoring



---



\# Project Timeline



The project is planned over \*\*8 weeks\*\*.



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



\# Project Structure (Planned)

Smart-Aquaculture-AI/  

│  

├── dataset/  

│  

├── ml-model/  

│ ├── training  

│ ├── preprocessing  

│ └── evaluation  

│  

├── mobile-app/  

│  

├── backend/  

│  

├── docs/  

│  

└── README.md





---



\# Future Improvements



Possible improvements include:



\- Expanding the dataset with more disease categories

\- Improving model accuracy with larger datasets

\- Real-time farm analytics

\- Government-level disease monitoring system

\- Multilingual farmer interface

\- Integration with IoT water quality sensors



---



\# References



1\. Islam, S. et al. \*Fish Production of Bangladesh and Impact on GDP\*, 2023  

2\. Ghose, B. \*Fisheries and Aquaculture in Bangladesh\*, 2014  

3\. Mamun Haque, M.I. \*Aquaculture Status and Disease Analysis in Bangladesh\*, 2022  

4\. Vasumathi, A. et al. \*Fish Disease Detection using Machine Learning\*, 2024  

5\. Nivin K. S., Hebri D. \*Efficient Fish Disease Detection in Aquaculture\*, 2025



---



\# License



This project is developed for academic purposes as part of \*\*CSE299 – Capstone Project\*\*.

