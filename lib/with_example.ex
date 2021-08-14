# here cases is used twice depending upon conditions of each one
# case Repo.insert(changeset) do
#   {:ok, user} ->
#     case Guardian.encode_and_sign(user, :token, claims) do
#       {:ok, token, full_claims} ->
#         important_stuff(token, full_claims)

#       error ->
#         error
#     end

#   error ->
#     error
# end

# # using with
# with {:ok, user} <- Repo.insert(changeset),
#      {:ok, token, full_claims} <- Guardian.encode_and_sign(user, :token, claims) do
#   important_stuff(token, full_claims)
# end

# its the same thing but less code and more clear. kind of like pipe operator for cases :P
