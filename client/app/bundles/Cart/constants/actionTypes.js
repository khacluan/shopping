import mirrorCreator from 'mirror-creator';
const actionTypes = mirrorCreator([
  'ADD_TO_CART', 'REMOVE_FROM_CART', 'RECEIVE_PRODUCTS'
]);
export default actionTypes;
