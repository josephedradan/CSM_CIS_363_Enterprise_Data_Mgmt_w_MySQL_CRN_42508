# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class AuthGroup(models.Model):
    name = models.CharField(unique=True, max_length=150)

    class Meta:
        managed = False
        db_table = 'auth_group'


class AuthGroupPermissions(models.Model):
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)
    permission = models.ForeignKey('AuthPermission', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_group_permissions'
        unique_together = (('group', 'permission'),)


class AuthPermission(models.Model):
    name = models.CharField(max_length=255)
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING)
    codename = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'auth_permission'
        unique_together = (('content_type', 'codename'),)


class AuthUser(models.Model):
    password = models.CharField(max_length=128)
    last_login = models.DateTimeField(blank=True, null=True)
    is_superuser = models.IntegerField()
    username = models.CharField(unique=True, max_length=150)
    first_name = models.CharField(max_length=30)
    last_name = models.CharField(max_length=150)
    email = models.CharField(max_length=254)
    is_staff = models.IntegerField()
    is_active = models.IntegerField()
    date_joined = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'auth_user'

    # def __str__(self):
    #     # IF something like "AuthUser object (25)" appears, then you need this to return the user name instead of
    #     return self.username


class AuthUserGroups(models.Model):
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_groups'
        unique_together = (('user', 'group'),)


class AuthUserUserPermissions(models.Model):
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    permission = models.ForeignKey(AuthPermission, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_user_permissions'
        unique_together = (('user', 'permission'),)


class Company(models.Model):
    company_id = models.AutoField(db_column='Company_ID', primary_key=True)  # Field name made lowercase.
    ceo = models.CharField(db_column='CEO', max_length=45)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'company'


class CreditCard(models.Model):
    credit_card_id = models.AutoField(db_column='Credit_card_ID', primary_key=True)  # Field name made lowercase.
    credit_card_number = models.CharField(db_column='Credit_card_number', max_length=16)  # Field name made lowercase.
    credit_card_cvn = models.CharField(db_column='Credit_card_cvn', max_length=3)  # Field name made lowercase.
    credit_card_expiration_date = models.DateField(
        db_column='Credit_card_expiration_date')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'credit_card'


class Customer(models.Model):
    id = models.OneToOneField('User', models.DO_NOTHING, db_column='id', primary_key=True)
    credit_card = models.ForeignKey(CreditCard, models.DO_NOTHING, db_column='Credit_card_ID', blank=True,
                                    null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'customer'


class CustomerOrder(models.Model):
    customer_order_id = models.AutoField(db_column='Customer_order_ID', primary_key=True)  # Field name made lowercase.
    id = models.ForeignKey(Customer, models.DO_NOTHING, db_column='id')

    class Meta:
        managed = False
        db_table = 'customer_order'


class Distributor(models.Model):
    id = models.OneToOneField('User', models.DO_NOTHING, db_column='id', primary_key=True)
    distributor_name = models.CharField(db_column='Distributor_name', max_length=255)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'distributor'


class DjangoAdminLog(models.Model):
    action_time = models.DateTimeField()
    object_id = models.TextField(blank=True, null=True)
    object_repr = models.CharField(max_length=200)
    action_flag = models.PositiveSmallIntegerField()
    change_message = models.TextField()
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING, blank=True, null=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'django_admin_log'


class DjangoContentType(models.Model):
    app_label = models.CharField(max_length=100)
    model = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'django_content_type'
        unique_together = (('app_label', 'model'),)


class DjangoMigrations(models.Model):
    app = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    applied = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_migrations'


class DjangoSession(models.Model):
    session_key = models.CharField(primary_key=True, max_length=40)
    session_data = models.TextField()
    expire_date = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_session'


class DjangoSite(models.Model):
    domain = models.CharField(unique=True, max_length=100)
    name = models.CharField(max_length=50)

    class Meta:
        managed = False
        db_table = 'django_site'


class ItemOrder(models.Model):
    customer_order = models.OneToOneField(CustomerOrder, models.DO_NOTHING, db_column='Customer_order_ID',
                                          primary_key=True)  # Field name made lowercase.
    seller_product_listing = models.ForeignKey('SellerProductListing', models.DO_NOTHING,
                                               db_column='Seller_product_listing_ID')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'item_order'
        unique_together = (('customer_order', 'seller_product_listing'),)


class Manufacturer(models.Model):
    id = models.OneToOneField('User', models.DO_NOTHING, db_column='id', primary_key=True)
    company = models.ForeignKey(Company, models.DO_NOTHING, db_column='Company_ID')  # Field name made lowercase.
    manufacturer_name = models.CharField(db_column='Manufacturer_name', max_length=255)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'manufacturer'


class PrimeMember(models.Model):
    prime_member_id = models.AutoField(db_column='Prime_member_ID', primary_key=True)  # Field name made lowercase.
    id = models.ForeignKey(Customer, models.DO_NOTHING, db_column='id')

    class Meta:
        managed = False
        db_table = 'prime_member'


class PrimePayment(models.Model):
    prime_member = models.ForeignKey(PrimeMember, models.DO_NOTHING,
                                     db_column='Prime_member_ID')  # Field name made lowercase.
    prime_payment_type = models.ForeignKey('PrimePaymentType', models.DO_NOTHING,
                                           db_column='Prime_payment_type_ID')  # Field name made lowercase.
    date_due = models.DateField(db_column='Date_due')  # Field name made lowercase.
    paid = models.IntegerField(db_column='Paid')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'prime_payment'


class PrimePaymentType(models.Model):
    prime_payment_type_id = models.AutoField(db_column='Prime_payment_type_ID',
                                             primary_key=True)  # Field name made lowercase.
    prime_payment_type = models.CharField(db_column='Prime_payment_type', max_length=45)  # Field name made lowercase.
    payment_amount = models.DecimalField(db_column='Payment_amount', max_digits=10,
                                         decimal_places=2)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'prime_payment_type'


class Product(models.Model):
    product_id = models.AutoField(db_column='Product_ID', primary_key=True)  # Field name made lowercase.
    id = models.ForeignKey(Manufacturer, models.DO_NOTHING, db_column='id')
    product_name = models.CharField(db_column='Product_name', max_length=255)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'product'


class ProductTagPair(models.Model):
    site_product = models.OneToOneField('SiteProduct', models.DO_NOTHING, db_column='Site_product_ID',
                                        primary_key=True)  # Field name made lowercase.
    product_tag = models.ForeignKey('TagInformation', models.DO_NOTHING,
                                    db_column='Product_tag_ID')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'product_tag_pair'
        unique_together = (('site_product', 'product_tag'),)


class Seller(models.Model):
    id = models.OneToOneField('User', models.DO_NOTHING, db_column='id', primary_key=True)
    credit_card = models.ForeignKey(CreditCard, models.DO_NOTHING, db_column='Credit_card_ID', blank=True,
                                    null=True)  # Field name made lowercase.
    seller_name = models.CharField(db_column='Seller_name', max_length=255)  # Field name made lowercase.
    seller_rating = models.IntegerField(db_column='Seller_rating')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'seller'

    def __str__(self):
        return f"{self.id}"  # Display the id only


class SellerProductListing(models.Model):
    seller_product_listing_id = models.AutoField(db_column='Seller_product_listing_ID',
                                                 primary_key=True)  # Field name made lowercase.
    id = models.ForeignKey(Seller, models.DO_NOTHING, db_column='id')
    product = models.ForeignKey(Product, models.DO_NOTHING, db_column='Product_ID')  # Field name made lowercase.
    site_product = models.ForeignKey('SiteProduct', models.DO_NOTHING,
                                     db_column='Site_product_ID')  # Field name made lowercase.
    product_pricing = models.DecimalField(db_column='Product_pricing', max_digits=10,
                                          decimal_places=2)  # Field name made lowercase.
    product_description = models.TextField(db_column='Product_description', blank=True,
                                           null=True)  # Field name made lowercase.
    product_image = models.TextField(db_column='Product_image', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'seller_product_listing'


class ShippingInformation(models.Model):
    shipping_id = models.AutoField(db_column='Shipping_ID', primary_key=True)  # Field name made lowercase.
    id = models.ForeignKey(Distributor, models.DO_NOTHING, db_column='id')
    customer_order = models.ForeignKey(CustomerOrder, models.DO_NOTHING,
                                       db_column='Customer_order_ID')  # Field name made lowercase.
    shipping_speed = models.CharField(db_column='Shipping_speed', max_length=45)  # Field name made lowercase.
    datetime_order = models.DateTimeField(db_column='Datetime_order')  # Field name made lowercase.
    datetime_ship = models.DateTimeField(db_column='Datetime_ship', blank=True, null=True)  # Field name made lowercase.
    datetime_arrive = models.DateTimeField(db_column='Datetime_arrive', blank=True,
                                           null=True)  # Field name made lowercase.
    delivery_notes = models.CharField(db_column='Delivery_notes', max_length=255, blank=True,
                                      null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'shipping_information'


class ShoppingCartItem(models.Model):
    shopping_cart_item_id = models.AutoField(db_column='Shopping_cart_item_ID',
                                             primary_key=True)  # Field name made lowercase.
    id = models.ForeignKey(Customer, models.DO_NOTHING, db_column='id')
    site_product = models.ForeignKey('SiteProduct', models.DO_NOTHING,
                                     db_column='Site_product_ID')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'shopping_cart_item'


class SiteProduct(models.Model):
    site_product_id = models.AutoField(db_column='Site_product_ID', primary_key=True)  # Field name made lowercase.
    product_rating_avg = models.IntegerField(db_column='Product_rating_avg', blank=True,
                                             null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'site_product'


class SiteProductComment(models.Model):
    site_product_comment_id = models.AutoField(db_column='Site_product_comment_ID',
                                               primary_key=True)  # Field name made lowercase.
    id = models.ForeignKey('User', models.DO_NOTHING, db_column='id')
    site_product = models.ForeignKey(SiteProduct, models.DO_NOTHING,
                                     db_column='Site_product_ID')  # Field name made lowercase.
    datetime_created = models.DateTimeField(db_column='Datetime_created', auto_now=True)  # Field name made lowercase.
    datetime_modified = models.DateTimeField(db_column='Datetime_modified', blank=True,
                                             null=True)  # Field name made lowercase.
    comments = models.TextField(db_column='Comments', blank=True, null=True)  # Field name made lowercase.
    images = models.TextField(db_column='Images', blank=True, null=True)  # Field name made lowercase.
    product_rating = models.IntegerField(db_column='Product_rating', blank=True,
                                         null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'site_product_comment'
        unique_together = (('site_product_comment_id', 'id'),)


class TagInformation(models.Model):
    product_tag_id = models.AutoField(db_column='Product_tag_ID', primary_key=True)  # Field name made lowercase.
    tag_title = models.CharField(db_column='Tag_Title', max_length=45)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'tag_information'


class User(models.Model):
    id = models.ForeignKey(AuthUser, models.DO_NOTHING, db_column='id', primary_key=True)
    address_1 = models.CharField(db_column='Address_1', max_length=255)  # Field name made lowercase.
    address_2 = models.CharField(db_column='Address_2', max_length=255, blank=True,
                                 null=True)  # Field name made lowercase.
    city = models.CharField(db_column='City', max_length=255)  # Field name made lowercase.
    state_province = models.CharField(db_column='State_Province', max_length=255)  # Field name made lowercase.
    zip = models.CharField(db_column='Zip', max_length=5, blank=True, null=True)  # Field name made lowercase.
    phone_1 = models.CharField(db_column='Phone_1', max_length=45)  # Field name made lowercase.
    phone_2 = models.CharField(db_column='Phone_2', max_length=45, blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'user'
    #
    # def __str__(self):
    #     return f"{self.id}"  # Return the id only
