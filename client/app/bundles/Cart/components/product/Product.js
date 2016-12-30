import React, { PropTypes } from 'react'

const Product = ({ price, quantity, title }) => (
  <div className='card'>
    <img

  </div>
)

Product.propTypes = {
  asin: PropTypes.string,
  price: PropTypes.number,
  quantity: PropTypes.number,
  brand: PropTypes.string,
  name: PropTypes.string,
  description: PropTypes.string
}

export default Product
