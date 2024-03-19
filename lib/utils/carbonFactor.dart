// Function to calculate carbon footprint
double calculateCarbonFootprint(String fuelType, double totalWeight) {
  double emissionFactor; // Variable to store the emission factor

  // Determining emission factor based on fuel type
  switch (fuelType.toLowerCase()) {
    case 'electricity':
      emissionFactor = 0.85; // Emission factor for electricity
      break;
    case 'petrol':
      emissionFactor = 2.296; // Emission factor for petrol
      break;
    case 'diesel':
      emissionFactor = 2.653; // Emission factor for diesel
      break;
    case 'lpg':
      emissionFactor =
          2.983; // Emission factor for LPG (liquefied petroleum gas)
      break;
    default:
      emissionFactor =
          1.5; // Default emission factor if fuel type is not recognized
  }

  // Calculating carbon footprint by multiplying total weight with emission factor
  return totalWeight * emissionFactor;
}
