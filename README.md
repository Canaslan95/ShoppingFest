# ShoppingFest
### Features

- Shopping fest is a mobile application that has only six shopping categories. 
- User can create product
- When user add product to shopping cart, it can be seen in the cart tab
- Firebase tools are used for database
- MVVM architecture is used 

### MVVM
Model View ViewModel

There are three layers.
Model represents data and business logic in the app
View is consisted of the UI Code such as Controllers and UI elements 
ViewModel is the br,dge between Model and View. . It does not have any clue which View has to use it as it does not have a direct reference to the View. So basically, the ViewModel should not be aware of the view who is interacting with. It interacts with the Model and exposes the observable that can be observed by the View.
