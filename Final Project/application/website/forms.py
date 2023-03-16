"""
Created by Joseph Edradan
Github: https://github.com/josephedradan

Date: 5/19/2020

Purpose:

Details:

Description:

Notes:

IMPORTANT NOTES:

Explanation:

Reference:

"""
from django import forms
from django.contrib.auth.models import User as User_auth  # Used for the actual User the proper way
from django.contrib.auth.forms import UserCreationForm

from .models import User, SiteProductComment, Product, SellerProductListing, SiteProduct, Manufacturer


class UserRegisterFormExtended(UserCreationForm):
    email = forms.EmailField()
    first_name = forms.CharField(max_length=45)  # Field name made lowercase.
    last_name = forms.CharField(max_length=45)  # Field name made lowercase.

    class Meta:
        model = User_auth
        fields = [
            'username',
            'first_name',
            'last_name',
            'email',
            'password1',
            'password2',
        ]


"""
Reference:
    https://www.youtube.com/watch?v=Tja4I_rgspI

"""


class UserRegisterFromCustom(forms.ModelForm):
    # username = forms.CharField(max_length=45)  # Field name made lowercase.
    # password = forms.CharField(max_length=45)  # Field name made lowercase.
    address_1 = forms.CharField(max_length=255)  # Field name made lowercase.
    address_2 = forms.CharField(max_length=255, required=False, )  # Field name made lowercase.
    city = forms.CharField(max_length=255)  # Field name made lowercase.
    state_province = forms.CharField(max_length=255)  # Field name made lowercase.
    zip = forms.CharField(max_length=5, required=False, )  # Field name made lowercase.
    phone_1 = forms.CharField(max_length=45)  # Field name made lowercase.
    phone_2 = forms.CharField(max_length=45, required=False, )  # Field name made lowercase.

    # email = forms.CharField(max_length=255)  # Field name made lowercase.

    class Meta:
        model = User
        fields = (
            # 'username', # Sub it with something
            # 'password', # Sub it with something
            'address_1',
            'address_2',
            'city',
            'state_province',
            'zip',
            'phone_1',
            'phone_2',
            # 'email', # Needs to be added
        )


"""
Reference:
    https://www.youtube.com/watch?v=zgF-KtQPqxQ
"""


class FormOrder(forms.Form):
    pass


class FormComment(forms.Form):
    comment = forms.CharField(widget=forms.Textarea, required=False)
    # images = forms.ImageField(required=False)

    # Choice Range: https://stackoverflow.com/questions/8859504/django-form-dropdown-list-of-numbers
    product_rating = forms.ChoiceField(required=False, choices=[(x, x) for x in range(1, 6)], initial=3)

    class Meta:
        model = SiteProductComment
        fields = (
            'comment',
            'product_rating',
        )


class CreateProduct(forms.Form):
    id = forms.ChoiceField(label="Manufacturer ID",
                           choices=[(x, x) for x in Manufacturer.objects.all().values_list('id', flat=True)])
    product_name = forms.CharField()

    # THIS IS HERE BECAUSE I CANT GET THE RESULT OF THE FIELD DIRECTLY FROM A forms.ModelForm OBJECT
    site_product_id = forms.ChoiceField(label="Site product ID", choices=[(x, x) for x in
                                                                          SiteProduct.objects.all().values_list(
                                                                              'site_product_id', flat=True)])

    class Meta:
        model = Product
        fields = (
            'id',
            'product_name',
        )


class CreateSellerProductListing(forms.ModelForm):
    # id = forms.IntegerField()  # Seller ID
    # product object

    product_pricing = forms.DecimalField()
    product_description = forms.CharField()

    class Meta:
        model = SellerProductListing
        fields = (
            'product_pricing',
            'product_description',
        )
