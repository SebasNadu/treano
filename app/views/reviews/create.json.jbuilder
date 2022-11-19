if @review.errors.any?
  json.form render(partial: "reviews/review_form", formats: :html, locals: {reviewable: @reviewable, review: @review })
else
  json.form render(partial: "reviews/review_form", class: "d-none", formats: :html, locals: {reviewable: @reviewable, review: Review.new })
  json.inserted_item render(partial: "reviews/review", formats: :html, locals: {review: @review})
end
