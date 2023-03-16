"""
Created by Joseph Edradan
Github: https://github.com/josephedradan

Date: 5/18/2020

Purpose:

Details:

Description:

Notes:

IMPORTANT NOTES:

Explanation:

Reference:

"""

from django.urls import path
from . import views
from django.contrib.auth import views as auth_views
"""
IMPORTANT NOTE: YOU MUST USE website: IN HTML FILES SUCH AS IN AN <a> tag like href="{% url 'website:home'%}"
because we have app_name
"""
app_name = 'website'

# Not using generic views
# urlpatterns = [
#     # ex: /polls/
#     path('', views.index, name='index'),
#     # TAKE ANY ARBITRARY NUMBER FROM THE URL AND RUN the views.detail FUNCTION WITH TEH URL ARGUMENT AS A PARAMETER
#     # ex: /polls/5/
#     path('<int:question_id>/', views.detail, name='detail'),
#     # ex: /polls/5/results/
#     path('<int:question_id>/results/', views.results, name='results'),
#     # ex: /polls/5/vote/
#     path('<int:question_id>/vote/', views.vote, name='vote'),
# ]

# Using generic views
urlpatterns = [
    # path('', views.HomeView.as_view(), name='index'),
    path('', views.PageHome.as_view(), name='home'),  # The default page will be from home since the default in the main urls is ''
    # ex: /polls/5/
    # path('<int:pk>/', views.DetailView.as_view(), name='detail'),  # Generic view
    # path('<int:pk>/results/', views.ResultsView.as_view(), name='results'),  # Generic view
    # path('<int:question_id>/vote/', views.vote, name='vote'),  # Non Generic view

    # path('product/', views.invalid_url, name='product'),
    path('product/<int:site_product_id>/', views.PageProduct.as_view(), name='product'),
    path('register', views.page_register, name='register'),
    path('login/', auth_views.LoginView.as_view(template_name='users/login.html'), name='login'),
    path('logout/', auth_views.LogoutView.as_view(template_name='users/logout.html'), name='logout'),  # No template will result in the admin logout page
    path('profile/', views.PageProfile.as_view(), name='profile'),
    # path('removeFromOrder/<int:customer_order_id>/<int:seller_product_listing_id>/',views.site_remove_from_order, name='remove_from_order'),
    # path('deleteOrder/<int:customer_order_id>/', views.site_delete_order, name='delete_order'),
    # path('createOrder/', views.site_create_order, name='create_customer_order'),
    # path('deleteSellerProductListing/<int:seller_product_listing_id>/',views.site_delete_seller_product_listing, name='delete_seller_product_listing'),
    path('createSellerProductListing/', views.PageCreateSellerProductListing.as_view(), name='create_seller_product_listing')
]
