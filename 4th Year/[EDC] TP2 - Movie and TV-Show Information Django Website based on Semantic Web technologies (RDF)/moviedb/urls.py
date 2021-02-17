"""moviedb URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from app import views

handler404 = views.handler404
handler500 = views.handler500

urlpatterns = [
    path('', views.home, name='home'),
    path('trailers/', views.news, name='news'),
    path('list/', views.list, name='list'),
    path('stats/', views.stats, name='stats'),
    path('movie/<slug:id>', views.single, name='movie'),
    path('series/<slug:id>', views.single, name='serie'),
    path('review/<slug:mid>/<slug:rid>', views.review, name='review'),
    path('person/<slug:pid>', views.person, name='person')
]
