if @review.persisted?
  json.form render(partial: "shared/new_review", class: "d-none", formats: :html, locals: {reviewable: @reviewable, review: Review.new})
  json.inserted_item render(partial: "shared/review", formats: :html, locals: {review: @review})
else
  json.form render(partial: "reviews/new_form", formats: :html, locals: {reviewable: @reviewable, review: @review})
end
