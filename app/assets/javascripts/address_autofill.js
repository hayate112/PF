$(function() {
  return $('#user_postcode').jpostal({
    postcode: ['#user_postcode'],
    address: {
      '#user_prefectures': '%3',
      '#user_city': '%4%5%6%7',
    },
  });
});