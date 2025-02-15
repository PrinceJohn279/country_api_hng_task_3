# Country API

## Overview
The Country API is a RESTful service that provides information about countries. It allows users to retrieve data such as country names, capitals, population, and more.

## Features
- Retrieve a list of all countries
- Get detailed information about a specific country 
- Search for countries by name {not yet implemented as at time of upload}
- Filter countries by region or subregion {not yet implemented as at time of upload}

## Endpoints
### Get All Countries
- **URL:** `/api/countries`
- **Method:** `GET`
- **Description:** Retrieves a list of all countries.

### Get Country by Name
- **URL:** `/api/countries/{name}`
- **Method:** `GET`
- **Description:** Retrieves detailed information about a specific country by its name.
- **URL Parameters:**
    - `name` (string): The name of the country.

### Search Countries
- **URL:** `/api/countries/search`
- **Method:** `GET`
- **Description:** Searches for countries by name.
- **Query Parameters:**
    - `query` (string): The search term.

### Filter Countries by Region
- **URL:** `/api/countries/region/{region}`
- **Method:** `GET`
- **Description:** Retrieves a list of countries in a specific region.
- **URL Parameters:**
    - `region` (string): The region name.

## Installation
1. Clone the repository:
     ```bash
     git clone https://github.com/princeJ/country_api.git
     ```
2. Navigate to the project directory:
     ```bash
     cd country_api
     ```
3. Install dependencies:
     ```bash
     npm install
     ```

## Usage
1. Start the server:
     ```bash
     npm start
     ```
2. Access the API at `https://restcountries.com/v3.1/all`.

## Contributing
Contributions are welcome! Please fork the repository and submit a pull request.

## License
This project is licensed under the MIT License.
