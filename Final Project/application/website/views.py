from django.contrib import messages
from django.contrib.auth import get_user
from django.contrib.auth.decorators import login_required
from django.contrib.auth.forms import UserCreationForm
from django.shortcuts import render

# Create your views here.
from django.shortcuts import render, get_object_or_404, redirect
from django.db import connection
from django.http import HttpResponse, Http404, HttpResponseRedirect
from django.utils import timezone
from django.utils.decorators import method_decorator
from django.views import generic, View

from .models import (User,
                     SiteProduct,
                     SiteProductComment,
                     SellerProductListing,
                     Customer,
                     Seller,
                     Manufacturer,
                     AuthUser)

from .forms import *

"""


Reference:
    How to log a user in¶
    https://docs.djangoproject.com/en/3.0/topics/auth/default/
    
    Django - How to use decorator in class-based view methods?
    https://stackoverflow.com/questions/31633259/django-how-to-use-decorator-in-class-based-view-methods
    
    Django form with two submit buttons . . . one requires fields and one doesn't 
    (multiple forms)
    https://stackoverflow.com/questions/35666570/django-form-with-two-submit-buttons-one-requires-fields-and-one-doesnt
    
    Setting the selected value on a Django forms.ChoiceField 
    (initial value for a field)
    https://stackoverflow.com/questions/657607/setting-the-selected-value-on-a-django-forms-choicefield
    
    Call Django on HTML button click
    (Button and method='GET' in HTML for calling a view) 
    https://stackoverflow.com/questions/48438575/call-django-on-html-button-click/48438962
    
    Field value not turning up in request.POST querydict - python django
    (HTML Form format)
    https://stackoverflow.com/questions/32297532/field-value-not-turning-up-in-request-post-querydict-python-django
"""


# TODO: WE GET ERROR IF WE DELETE IF IT'S IN A SHIPPING INFORMATION

def _console_printer(text):
    spacing = 100
    print(spacing * "*")

    if isinstance(text, (list, tuple)):
        for i in text:
            if isinstance(i, dict):
                for key, value in i.items():
                    print(key)
                    if isinstance(value, (list, tuple)):
                        [print('\t', z) for z in value]
            else:
                print(i)
    else:
        print(text)
    print(spacing * "*")


#
# class HomeView(generic.ListView):
#     # model = Question
#     template_name = 'home/home.html'


def invalid_url(request):
    # raise Http404("Invalid URL")
    return redirect('website:home')
    # return redirect('home/home.html') # Does not work as intended


class PageHome(View):
    def get(self, request, *args, **kwargs):
        """
        TODO:
        // SITE PRODUCTS

        :param request:
        :return:

        :param request:
        :param args:
        :param kwargs:
        :return:
        """

        # Get the tags for a site_product
        list_site_product_ids = SiteProduct.objects.raw(
            """
            SELECT Site_product_ID FROM site_product;
            """
        )

        list_dict_seller_product_listing_remaining = []

        for i in list_site_product_ids:
            # Calling procedure get_seller_product_listing_remaining in MySQL
            with connection.cursor() as cursor:
                cursor.callproc('cis_363_project.get_seller_product_listing_remaining', [i.site_product_id])
                seller_product_listing_remaining = cursor.fetchall()

                list_dict_seller_product_listing_remaining.append({i.site_product_id: seller_product_listing_remaining})

        # print(list_dict_seller_product_listing_remaining)

        seller_product_listing_remaining_header = (
            'Seller Product Listing ID', 'Seller ID', 'Seller Name', 'Seller Rating', 'Manufacturer Name',
            'Product Name', 'Product ID', 'Product Pricing', 'Product Description')

        context = {
            'list_dict_seller_product_listing_remaining': list_dict_seller_product_listing_remaining,
            'seller_product_listing_remaining_header': seller_product_listing_remaining_header
        }

        return render(request, 'home/home.html', context)
        # return HttpResponse("HELLO TEST")

    def post(self):
        pass


@method_decorator(login_required, name='dispatch')
class PageCreateSellerProductListing(View):

    # @method_decorator(login_required())
    def get(self, request, *args, **kwargs):
        if request.user.is_authenticated:
            form_product = CreateProduct()
            form_seller_product_listing = CreateSellerProductListing()

            context = {'form_product': form_product,
                       'form_seller_product_listing': form_seller_product_listing,
                       }

            return render(request, 'product/create_and_list_new_product.html', context)

    # @method_decorator(login_required())
    def post(self, request, *args, **kwargs):
        """
        SELLERS ONLY
          TODO: CREATE A SITE PRODUCT, ASSIGN THE PRODUCT ID TO IT

        :param request:
        :return:
        """

        if request.user.is_authenticated:

            user_current = request.user

            # Calling procedure is_seller in MySQL
            with connection.cursor() as cursor:
                cursor.callproc('cis_363_project.is_seller', [user_current.id])
                is_seller = cursor.fetchone()

            # print("-"*100)
            # print(is_seller)

            if is_seller[0] == 1:

                if request.method == 'POST':
                    form_product = CreateProduct(request.POST)
                    form_seller_product_listing = CreateSellerProductListing(request.POST)

                    if form_product.is_valid() and form_seller_product_listing.is_valid():
                        print("-" * 100)
                        print("form_product", form_product)
                        print("form_product", type(form_product))
                        print("form_product.id", type(form_product.cleaned_data.get('id')))

                        # FORM IS NOT A MODEL FORM BECAUSE OF THE MANUFACTURER ID
                        form_product_id = form_product.cleaned_data.get('id')
                        form_product_product_name = form_product.cleaned_data.get('product_name')
                        form_product_site_product_id = form_product.cleaned_data.get('site_product_id')

                        manufacturer_object = Manufacturer.objects.get(pk=form_product_id)

                        temp_product = Product.objects.create(
                            id=manufacturer_object,
                            product_name=form_product_product_name
                        )

                        temp_product.save()

                        seller_product_listing = form_seller_product_listing.save(commit=False)

                        seller_product_listing.id = Seller.objects.get(pk=user_current.id)

                        seller_product_listing.product = temp_product

                        seller_product_listing.site_product_id = form_product_site_product_id

                        seller_product_listing.save()

                        messages.success(request,
                                         f'You have created a new Seller product listing ID: {seller_product_listing.seller_product_listing_id} in site_product_id: {seller_product_listing.site_product_id}')

                        return redirect('website:profile')
                    else:
                        return redirect("website:home")


@method_decorator(login_required, name='dispatch')
class PageProfile(View):
    """
    TODO: PRIME, PRIME PAYMENT, SHOPPING CART, ORDERS, CREDIT CARD

    """

    def get(self, request, *args, **kwargs):
        user_current = request.user
        print("FUCKSDCKSDCSDFSDF")
        if request.user.is_authenticated:
            # Calling procedure is_seller in MySQL
            with connection.cursor() as cursor:
                cursor.callproc('cis_363_project.is_seller', [user_current.id])
                is_seller = cursor.fetchone()

            if is_seller[0] == 1:
                return self.get_seller(request, user_current, *args, **kwargs)
            else:
                return self.get_customer(request, user_current, *args, **kwargs)
        else:
            return invalid_url(request)

    def get_customer(self, request, user_current, *args, **kwargs):
        # Calling procedure is_prime in MySQL
        with connection.cursor() as cursor:
            cursor.callproc('cis_363_project.is_prime', [user_current.id])
            prime_member = cursor.fetchone()

        # Calling procedure get_user_all_orders in MySQL
        with connection.cursor() as cursor:
            cursor.callproc('cis_363_project.get_user_orders_all', [user_current.id])
            user_all_orders = cursor.fetchall()

        list_dict_user_orders_all = []

        for order_id, customer_order_id, sum_total in user_all_orders:
            # Calling procedure get_items_in_customer_order_id in MySQL
            with connection.cursor() as cursor:
                cursor.callproc('cis_363_project.get_items_in_customer_order_id', [order_id])
                order = cursor.fetchall()

                list_dict_user_orders_all.append({order_id: order})

        context = {
            'is_customer': True,
            'user_all_orders': user_all_orders,
            'user_all_orders_headers': ("Order ID", "Amount of items in order", "Order Total"),
            'list_dict_user_orders_all': list_dict_user_orders_all,
            'list_user_orders_all_headers': ("Seller product listing ID", "Name", "Price", "Description",
                                             "Seller", "Manufacturer"),
            'prime_member': True if prime_member else False,
            'user_profile': User.objects.get(pk=user_current.id)
        }

        # print(user_all_orders)
        # print(list_dict_user_orders_all)

        return render(request, 'users/profile.html', context)

    def get_seller(self, request, user_current, *args, **kwargs):

        # Calling procedure is_prime in MySQL
        with connection.cursor() as cursor:
            cursor.callproc('cis_363_project.seller_all_site_product_id', [user_current.id])
            seller_all_site_product_id = cursor.fetchall()

        _console_printer(seller_all_site_product_id)
        list_dict_seller_product_listing_sold = []

        for i in seller_all_site_product_id:
            # Calling procedure get_seller_product_listing_sold in MySQL
            with connection.cursor() as cursor:
                cursor.callproc('cis_363_project.get_seller_product_listing_sold', [i[0], user_current.id])
                seller_product_listing_sold = cursor.fetchall()
                list_dict_seller_product_listing_sold.append({i[0]: seller_product_listing_sold})

        # Calling procedure get_seller_revenue in MySQL
        with connection.cursor() as cursor:
            cursor.callproc('cis_363_project.get_seller_revenue', [user_current.id])
            seller_revenue = cursor.fetchone()

        list_dict_seller_product_listing_not_sold = []

        for i in seller_all_site_product_id:
            # Calling procedure get_seller_items_not_sold in MySQL
            with connection.cursor() as cursor:
                cursor.callproc('cis_363_project.get_seller_product_listing_not_sold', [i[0], user_current.id])
                seller_items_not_sold = cursor.fetchall()
                list_dict_seller_product_listing_not_sold.append({i[0]: seller_items_not_sold})

        context = {
            'is_customer': False,
            "list_dict_seller_product_listing_sold": list_dict_seller_product_listing_sold,
            "seller_product_listing_sold_headers": ("Seller product listing ID", "Manufacturer", "Name",
                                                    "Product ID", "Product pricing", "Sold to User"),
            "seller_revenue": seller_revenue,
            "list_dict_seller_product_listing_not_sold": list_dict_seller_product_listing_not_sold,
            "seller_product_listing_not_sold_headers": ("Seller product listing ID",
                                                        "Product ID", "Product pricing",
                                                        "Name", "Manufacturer"),
            'user_profile': User.objects.get(pk=user_current.id)

        }

        _console_printer(list_dict_seller_product_listing_sold)
        _console_printer(seller_revenue)
        _console_printer(list_dict_seller_product_listing_not_sold)

        return render(request, 'users/profile.html', context)

    def post(self, request, *args, **kwargs):
        user_current = request.user
        print("-" * 100)
        print(request.POST)

        if request.user.is_authenticated:
            # Calling procedure is_seller in MySQL
            with connection.cursor() as cursor:
                cursor.callproc('cis_363_project.is_seller', [user_current.id])
                is_seller = cursor.fetchone()

            if is_seller[0] == 1:
                print("SELLER")
                return self.post_seller(request, user_current, *args, **kwargs)
            else:
                print("CUSTOMER")
                return self.post_customer(request, user_current, *args, **kwargs)
        else:
            return invalid_url(request)

    def post_customer(self, request, *args, **kwargs):
        if request.user.is_authenticated:

            if 'customer_create_order' in request.POST:
                """
                Original HTML:
                    <a href="{% url 'website:create_customer_order' %}">
                    <button type="button" class="btn btn-primary btn-sm">Create new Order</button>
                    </a>
                """

                # print(request.POST["customer_create_order"])

                # Calling procedure create_customer_order in MySQL
                with connection.cursor() as cursor:
                    cursor.callproc('cis_363_project.create_customer_order', [request.user.id])

                messages.success(request, f'You have created a new Order ID')
                return redirect('website:profile')

            elif 'customer_remove_item_from_order' in request.POST:
                """
                Original HTML:
                    <a href="{% url 'website:remove_from_order' 
                    customer_order_id=order_id 
                    seller_product_listing_id=row.0 %}">
                    <button type="button" class="btn btn-danger">Remove</button>
                    </a>
                """
                # Calling procedure remove_from_item_order in MySQL
                with connection.cursor() as cursor:
                    cursor.callproc('cis_363_project.remove_from_item_order',
                                    [request.POST["customer_order_id"], request.POST["seller_product_listing_id"]])

                messages.warning(request,
                                 f'You have deleted Seller product listing ID from your Order: {request.POST["seller_product_listing_id"]}')
                return redirect('website:profile')

            elif 'customer_delete_order':
                # Calling procedure delete_order in MySQL
                with connection.cursor() as cursor:
                    cursor.callproc('cis_363_project.delete_order', [request.POST["customer_order_id"]])

                messages.warning(request, f'You have deleted Your Order ID: {request.POST["customer_order_id"]}')
                return redirect('website:profile')

    def post_seller(self, request, *args, **kwargs):
        if 'seller_delete_product_listing' in request.POST:
            """
    
            Original HTML:
                <a href="{% url 'website:delete_order' customer_order_id=order_id %}">
                <button type="button" class="btn btn-danger btn-sm">Delete</button>
                </a>
    
            """
            # Calling procedure delete_seller_product_listing in MySQL
            with connection.cursor() as cursor:
                cursor.callproc('cis_363_project.delete_seller_product_listing',
                                [request.POST['site_product_id']])
            return redirect('website:profile')


def page_register(request):
    if request.method == 'POST':
        form_default = UserRegisterFormExtended(request.POST)
        form_user_profile = UserRegisterFromCustom(request.POST)

        if form_default.is_valid() and form_user_profile.is_valid():
            # print("DEFUALT")
            # print(form_default)

            # print("CUSTOM")
            # print(form_user_profile)

            # username = form_default.cleaned_data.get('username')  # Take by form_default
            # password = form_default.cleaned_data.get('password')  # DNE because using password1 and password2
            # address_1 = form_default.cleaned_data.get('address_1')
            # address_2 = form_default.cleaned_data.get('address_2')
            # city = form_default.cleaned_data.get('city')
            # state_province = form_default.cleaned_data.get('state_province')
            # zip = form_default.cleaned_data.get('zip')
            # phone_1 = form_default.cleaned_data.get('phone_1')
            # phone_2 = form_default.cleaned_data.get('phone_2')
            # email = form_default.cleaned_data.get('email')  # Take by form_default

            """
            Hacky overriding for form inputs
                https://stackoverflow.com/questions/3207606/how-do-i-change-the-value-of-submitted-form-data-using-form-object-and-redisplay/3209005
            """

            # data = form_user.data.copy()
            #
            # data['username'] = form_default.data['username']
            # data['password'] = form_default.data['password1']
            # data['email'] = form_default.data['email']
            #
            # form_user.data = data

            # x = (
            # 'username', 'password', 'address_1', 'address_2', 'city', 'state_province', 'zip', 'phone_1', 'phone_2',
            # 'email')
            # [print(form_user.data[i]) for i in x]

            form_default_saved = form_default.save()  # id comes form_default.save()

            form_default_saved_id = form_default_saved.id

            print("-" * 200)
            print("form_default.save() ID: {}".format(form_default_saved_id))
            print("form_default.save() type: {}".format(type(form_default_saved)))  #
            print("-" * 200)

            user_profile = form_user_profile.save(commit=False)

            auth_user = AuthUser.objects.get(pk=form_default_saved_id)

            user_profile.id = auth_user  # GET ID FROM THE default_save AND SET IT FOR user_profile

            user_profile.save()  # Returns None

            # type(user_profile) Is of type User

            Customer.objects.create(id=user_profile).save()

            messages.success(request, f'Your account has been created! You are now able to log in')
            return redirect('website:login')
    else:
        form_default = UserRegisterFormExtended()
        form_user_profile = UserRegisterFromCustom()

    context = {'form_default': form_default,
               'form_user_profile': form_user_profile,
               }

    return render(request, 'users/register.html', context)


class PageProduct(View):

    def __init__(self):
        """
        Does not work??

        """
        # super().__init__(self)
        self.form_comment_initial_data = {
            'product_rating': 5,

        }

    def get(self, request, *args, **kwargs):

        _console_printer(kwargs)
        row_SiteProduct = get_object_or_404(SiteProduct, site_product_id=kwargs['site_product_id'])
        row_SiteProductComment = SiteProductComment.objects.filter(site_product_id=kwargs['site_product_id'])

        # test = get_object_or_404(User)
        _console_printer(User)

        # Calling procedure get_site_product_tags in MySQL
        with connection.cursor() as cursor:
            cursor.callproc('cis_363_project.get_site_product_tags', [row_SiteProduct.site_product_id])
            row_ProductTagPair = cursor.fetchone()

        # Calling procedure get_site_product_amount_products in MySQL
        with connection.cursor() as cursor:
            cursor.callproc('cis_363_project.get_site_product_amount_products', [row_SiteProduct.site_product_id])
            amount_products_site_product = cursor.fetchone()

        # Calling procedure get_seller_product_listing_remaining in MySQL
        with connection.cursor() as cursor:
            cursor.callproc('cis_363_project.get_seller_product_listing_remaining', [row_SiteProduct.site_product_id])
            seller_product_listing_remaining = cursor.fetchall()

        seller_product_listing_remaining_headers = (
            'Seller Product Listing ID',
            'Seller ID',
            'Seller Name',
            'Seller Rating',
            'Manufacturer Name',
            'Product Name',
            'Product ID',
            'Product Pricing',
            'Product Description'
        )

        form_comment = FormComment(request.POST, initial=self.form_comment_initial_data)

        context = {
            'row_SiteProduct': row_SiteProduct,
            'row_SiteProductComment': row_SiteProductComment,
            'row_ProductTagPair': row_ProductTagPair,
            'amount_products_site_product': amount_products_site_product[0],
            'seller_product_listing_remaining_headers': seller_product_listing_remaining_headers,
            'seller_product_listing_remaining': seller_product_listing_remaining,
            'form_comment': form_comment,
        }

        _console_printer(row_SiteProduct)
        _console_printer(row_SiteProductComment)
        _console_printer(row_ProductTagPair)
        _console_printer(amount_products_site_product[0])
        _console_printer(seller_product_listing_remaining)

        return render(request, 'product/product.html', context)

    def post(self, request, *args, **kwargs):
        """
        TODO: Dup comments are allowed, fix this in DB, ADD TO SHOPPING CART

        Reference:
            How to comment
            https://youtu.be/An4hW4TjKhE?t=939

            Post/Redirect/Get (You want to redirect after a POST request to prevent double posting)
            https://en.wikipedia.org/wiki/Post/Redirect/Get

            Button type “button” vs. “submit”
            https://stackoverflow.com/questions/37736056/button-type-button-vs-submit
                A button with type "button" won't submit a form but one with no type or type=submit (the default) will.
                Buttons with type=submit are nearly the same as inputs with type=submit but buttons are able to contain
                HTML content.

            How can I build multiple submit buttons django form?
            https://stackoverflow.com/questions/866272/how-can-i-build-multiple-submit-buttons-django-form

        :param request:
        :param args:
        :param kwargs:
        :return:
        """
        # _console_printer(kwargs)

        if request.user.is_authenticated:

            if 'seller_product_listing_id' in request.POST:
                seller_product_listing_id = request.POST['seller_product_listing_id']  # Id of the product

                # print("-" * 100)
                # print("request.user.id", request.user.id)
                # print("seller_product_listing_id", seller_product_listing_id)
                # print("site_product_id", kwargs['site_product_id'])

                # Calling procedure add_item_to_order_latest in MySQL
                with connection.cursor() as cursor:
                    cursor.callproc('cis_363_project.add_item_to_order_latest',
                                    [request.user.id, seller_product_listing_id])

            else:
                """
                Alternative to the button, in the html file:
                    <input type="submit" value="post" class='btn btn-outline-info' name="post_comment">
                    <button type="submit" class="btn btn-primary" name="post_comment">Post</button>

                """
                form_comment = FormComment(request.POST, initial=self.form_comment_initial_data)
                print(request.POST)

                if form_comment.is_valid():
                    """
                    Reference:
                        Django: Model Form “object has no attribute 'cleaned_data'”
                        https://stackoverflow.com/questions/4308527/django-model-form-object-has-no-attribute-cleaned-data
                            Forms only get a cleaned_data attribute when is_valid() has been called,

                    """
                    """
                    Reference:
                        Django form with two submit buttons . . . one requires fields and one doesn't
                        https://stackoverflow.com/questions/35666570/django-form-with-two-submit-buttons-one-requires-fields-and-one-doesnt
                    """
                    form_comment.fields['comment'].required = True
                    form_comment.fields['product_rating'].requied = True

                    comment = form_comment.cleaned_data.get('comment')
                    product_rating = form_comment.cleaned_data.get('product_rating')  # Don't use request.POST.get

                    # print("-" * 100)
                    # print("comments", comment)
                    # print("product_rating", product_rating)
                    # print("request.user.id", request.user.id)
                    # print("get_user(request)", get_user(request))
                    # print("type(get_user(request))", type(get_user(request)))

                    """
                    Create an instance of the object
                    
                    Alternative (Create then save automatically)
                    SiteProductComment.objects.create()
                    
                    Reference:
                        https://micropyramid.com/blog/django-model-managers-and-properties/
                    """
                    site_product_comment = SiteProductComment(id=User.objects.get(pk=request.user.id),
                                                              site_product=SiteProduct.objects.get(
                                                                  pk=kwargs['site_product_id']
                                                              ),
                                                              comments=comment,
                                                              product_rating=product_rating
                                                              )
                    site_product_comment.save()

        """
        MUST CALL OR YOU WILL POST AGAIN
        Reference:
            Django: Redirect to same page after POST method using class based views
            https://stackoverflow.com/questions/39560175/django-redirect-to-same-page-after-post-method-using-class-based-views
        """
        return HttpResponseRedirect(self.request.path_info)

        # This does not work propertly
        # return self.get(request, *args, **kwargs)
